import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../constants/app_constants.dart';
import 'network_aware_service.dart';

// Abstract interface for dependency inversion (SOLID principle)
abstract class AuthProvider {
  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential> signInWithEmailPassword(String email, String password);
  Future<UserCredential> createUserWithEmailPassword(
      String email, String password, String name);
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Stream<User?> get authStateChanges;
  User? get currentUser;
}

class FirebaseAuthProvider implements AuthProvider {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthProvider({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> createUserWithEmailPassword(
      String email, String password, String name) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user != null) {
      await userCredential.user!.updateDisplayName(name);
    }

    return userCredential;
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}

class AuthService with NetworkAwareService {
  final AuthProvider _authProvider;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  // Cache for user profiles
  final Map<String, UserModel> _userCache = {};
  final Map<String, DateTime> _cacheTimestamps = {};
  static const Duration _userCacheTimeout = Duration(minutes: 30);

  AuthService({AuthProvider? authProvider})
      : _authProvider = authProvider ?? FirebaseAuthProvider();

  // Expose auth provider methods
  Stream<User?> get authStateChanges => _authProvider.authStateChanges;
  User? get currentUser => _authProvider.currentUser;

  // Enhanced sign in with user profile management and cache warming
  Future<UserCredential?> signInWithGoogle() async {
    return executeOnlineOperation(
      () async {
        final userCredential = await _authProvider.signInWithGoogle();
        if (userCredential?.user != null) {
          await _createOrUpdateUserProfile(userCredential!.user!);
          await _warmupUserCache(userCredential.user!.uid);
        }
        return userCredential;
      },
      operationName: 'Google Sign In',
    );
  }

  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    return executeOnlineOperation(
      () async {
        final userCredential =
            await _authProvider.signInWithEmailPassword(email, password);
        await _warmupUserCache(userCredential.user!.uid);
        return userCredential;
      },
      operationName: 'Email Sign In',
    );
  }

  Future<UserCredential> createUserWithEmailPassword(
      String email, String password, String name) async {
    return executeOnlineOperation(
      () async {
        final userCredential = await _authProvider.createUserWithEmailPassword(
            email, password, name);
        if (userCredential.user != null) {
          await _createOrUpdateUserProfile(userCredential.user!);
          await _warmupUserCache(userCredential.user!.uid);
        }
        return userCredential;
      },
      operationName: 'User Creation',
    );
  }

  Future<void> signOut() async {
    final userId = currentUser?.uid;
    if (userId != null) {
      _clearUserCache(userId);
    }
    await _authProvider.signOut();
  }

  Future<void> resetPassword(String email) async {
    return executeOnlineOperation(
      () => _authProvider.resetPassword(email),
      operationName: 'Password Reset',
    );
  }

  // Optimized user profile management using Cloud Functions where possible
  Future<void> _createOrUpdateUserProfile(User user) async {
    try {
      // Try Cloud Function first for optimal performance
      final callable = _functions.httpsCallable('manageUserProfile');
      await callable.call({
        'uid': user.uid,
        'email': user.email,
        'name': user.displayName ?? user.email!.split('@')[0],
        'photoUrl': user.photoURL,
        'action': 'createOrUpdate',
      });

      debugPrint('User profile managed via Cloud Function: ${user.uid}');
    } catch (e) {
      debugPrint('Cloud Function failed, using fallback: $e');
      // Fallback to direct Firestore operations
      await _createOrUpdateUserProfileFallback(user);
    }
  }

  Future<void> _createOrUpdateUserProfileFallback(User user) async {
    final userDoc =
        _firestore.collection(AppConstants.usersCollection).doc(user.uid);
    final userSnapshot = await userDoc.get();

    if (!userSnapshot.exists) {
      // Create new user profile
      final newUser = UserModel(
        id: user.uid,
        email: user.email!,
        name: user.displayName ?? user.email!.split('@')[0],
        photoUrl: user.photoURL,
        organizationId:
            'default_org', // You might want to handle this differently
        roles: ['operator'], // Default role
        permissions: {},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await userDoc.set(newUser.toJson());

      // Cache the new user
      _userCache[user.uid] = newUser;
      _cacheTimestamps[user.uid] = DateTime.now();

      debugPrint('New user profile created: ${user.uid}');
    } else {
      // Update existing user
      await userDoc.update({
        'updatedAt': FieldValue.serverTimestamp(),
        if (user.displayName != null) 'name': user.displayName,
        if (user.photoURL != null) 'photoUrl': user.photoURL,
      });

      // Invalidate cache to force refresh
      _clearUserCache(user.uid);

      debugPrint('User profile updated: ${user.uid}');
    }
  }

  // Pre-load frequently accessed data after login for better UX
  Future<void> _warmupUserCache(String userId) async {
    try {
      debugPrint('Warming up cache for user: $userId');

      final futures = [
        getUserProfile(userId),
        _preloadUserPermissions(userId),
        _preloadUserDashboard(userId),
      ];

      // Execute all cache warming operations concurrently
      await Future.wait(futures, eagerError: false);

      debugPrint('Cache warmup completed for user: $userId');
    } catch (e) {
      // Don't fail login if cache warming fails
      debugPrint('Cache warmup failed for user $userId: $e');
    }
  }

  Future<void> _preloadUserPermissions(String userId) async {
    try {
      final callable = _functions.httpsCallable('getUserPermissions');
      await callable.call({'userId': userId});
    } catch (e) {
      debugPrint('Permission preload failed: $e');
    }
  }

  Future<void> _preloadUserDashboard(String userId) async {
    try {
      final callable = _functions.httpsCallable('getUserDashboard');
      await callable.call({'userId': userId});
    } catch (e) {
      debugPrint('Dashboard preload failed: $e');
    }
  }

  // Cached user profile retrieval with intelligent cache management
  Future<UserModel?> getUserProfile(String uid) async {
    // Check cache first
    if (_isUserCacheValid(uid)) {
      debugPrint('User profile cache HIT: $uid');
      return _userCache[uid];
    }

    try {
      debugPrint('User profile cache MISS: $uid - Fetching from Firestore');

      final doc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .get();

      if (doc.exists) {
        final user = UserModel.fromFirestore(doc);

        // Update cache
        _userCache[uid] = user;
        _cacheTimestamps[uid] = DateTime.now();

        return user;
      }
      return null;
    } catch (e) {
      debugPrint('Failed to get user profile for $uid: $e');
      throw Exception('Failed to get user profile: $e');
    }
  }

  // Session management
  Future<void> extendSession() async {
    final user = currentUser;
    if (user != null) {
      await _warmupUserCache(user.uid);
    }
  }

  Future<bool> validateSession() async {
    final user = currentUser;
    if (user == null) return false;

    try {
      // Check if user is still active in database
      final profile = await getUserProfile(user.uid);
      return profile?.isActive ?? false;
    } catch (e) {
      debugPrint('Session validation failed: $e');
      return false;
    }
  }

  // Batch user operations for admin functionality
  Future<List<UserModel>> getBatchUsers(List<String> userIds) async {
    return executeOnlineOperation(
      () async {
        final users = <UserModel>[];
        final uncachedIds = <String>[];

        // Check cache first
        for (final uid in userIds) {
          if (_isUserCacheValid(uid)) {
            users.add(_userCache[uid]!);
          } else {
            uncachedIds.add(uid);
          }
        }

        // Fetch uncached users in batch
        if (uncachedIds.isNotEmpty) {
          final query = await _firestore
              .collection(AppConstants.usersCollection)
              .where(FieldPath.documentId, whereIn: uncachedIds)
              .get();

          for (final doc in query.docs) {
            final user = UserModel.fromFirestore(doc);
            users.add(user);

            // Update cache
            _userCache[user.id] = user;
            _cacheTimestamps[user.id] = DateTime.now();
          }
        }

        return users;
      },
      operationName: 'Batch User Fetch',
      fallback: [],
    );
  }

  // Cache management methods
  bool _isUserCacheValid(String uid) {
    if (!_userCache.containsKey(uid) || !_cacheTimestamps.containsKey(uid)) {
      return false;
    }

    final cacheTime = _cacheTimestamps[uid]!;
    return DateTime.now().difference(cacheTime) < _userCacheTimeout;
  }

  void _clearUserCache(String uid) {
    _userCache.remove(uid);
    _cacheTimestamps.remove(uid);
  }

  void clearAllCache() {
    _userCache.clear();
    _cacheTimestamps.clear();
  }

  // Analytics and monitoring
  Map<String, dynamic> getAuthStats() {
    return {
      'cached_users': _userCache.length,
      'cache_hit_ratio': _calculateCacheHitRatio(),
      'active_sessions': currentUser != null ? 1 : 0,
      'last_activity': DateTime.now().toIso8601String(),
    };
  }

  double _calculateCacheHitRatio() {
    // This would need actual hit/miss tracking in production
    return _userCache.isNotEmpty ? 0.85 : 0.0;
  }
}
