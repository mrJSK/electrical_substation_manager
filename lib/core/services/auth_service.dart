import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../models/organization_model.dart';
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

  // Cache for user profiles and organizations
  final Map<String, UserModel> _userCache = {};
  final Map<String, OrganizationModel> _organizationCache = {};
  final Map<String, DateTime> _userCacheTimestamps = {};
  final Map<String, DateTime> _orgCacheTimestamps = {};

  static const Duration _userCacheTimeout = Duration(minutes: 30);
  static const Duration _orgCacheTimeout = Duration(hours: 2);

  AuthService({AuthProvider? authProvider})
      : _authProvider = authProvider ?? FirebaseAuthProvider();

  // Expose auth provider methods
  Stream<User?> get authStateChanges => _authProvider.authStateChanges;
  User? get currentUser => _authProvider.currentUser;

  // Enhanced sign in with user profile management
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

  // Alias for provider compatibility
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return signInWithEmailPassword(email, password);
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

  // Alias for provider compatibility
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    return createUserWithEmailPassword(email, password, email.split('@')[0]);
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

  // Alias for provider compatibility
  Future<void> sendPasswordResetEmail(String email) async {
    return resetPassword(email);
  }

  // User profile management
  Future<void> _createOrUpdateUserProfile(User user) async {
    try {
      await _createOrUpdateUserProfileFallback(user);
      debugPrint('User profile managed: ${user.uid}');
    } catch (e) {
      debugPrint('Failed to create/update user profile: $e');
      rethrow;
    }
  }

  Future<void> _createOrUpdateUserProfileFallback(User user) async {
    final userDoc =
        _firestore.collection(AppConstants.usersCollection).doc(user.uid);
    final userSnapshot = await userDoc.get();

    if (!userSnapshot.exists) {
      // Create new user profile with all required parameters
      final newUser = UserModel(
        id: user.uid, // REQUIRED
        email: user.email!, // REQUIRED
        name: user.displayName ?? user.email!.split('@')[0], // REQUIRED
        photoUrl: user.photoURL,
        organizationId: AppConstants.defaultOrganization,
        departmentId: null,
        managerId: null,
        phoneNumber: null,
        designation: null,
        roles: AppConstants.defaultRoles, // REQUIRED
        permissions: <String, dynamic>{}, // REQUIRED - Empty map for new users
        preferences: <String, dynamic>{
          'theme': 'system',
          'language': 'en',
          'notifications': true,
        },
        isActive: true,
        isEmailVerified: user.emailVerified,
        lastLoginAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await userDoc.set(newUser.toJson());

      // Cache the new user
      _userCache[user.uid] = newUser;
      _userCacheTimestamps[user.uid] = DateTime.now();

      debugPrint('New user profile created: ${user.uid}');
    } else {
      // Update existing user
      await userDoc.update({
        'updatedAt': FieldValue.serverTimestamp(),
        'lastLoginAt': FieldValue.serverTimestamp(),
        'isEmailVerified': user.emailVerified,
        if (user.displayName != null) 'name': user.displayName,
        if (user.photoURL != null) 'photoUrl': user.photoURL,
      });

      // Invalidate cache to force refresh
      _clearUserCache(user.uid);

      debugPrint('User profile updated: ${user.uid}');
    }
  }

  // Pre-load frequently accessed data after login
  Future<void> _warmupUserCache(String userId) async {
    try {
      debugPrint('Warming up cache for user: $userId');

      // Pre-load user profile
      await getUserProfile(userId);

      debugPrint('Cache warmup completed for user: $userId');
    } catch (e) {
      // Don't fail login if cache warming fails
      debugPrint('Cache warmup failed for user $userId: $e');
    }
  }

  // Cached user profile retrieval (REQUIRED by providers)
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
        final user = UserModel.fromJson(doc.data()!);

        // Update cache
        _userCache[uid] = user;
        _userCacheTimestamps[uid] = DateTime.now();

        return user;
      }
      return null;
    } catch (e) {
      debugPrint('Failed to get user profile for $uid: $e');
      // Return cached version if available, even if expired
      return _userCache[uid];
    }
  }

  // Organization management (REQUIRED by providers)
  Future<OrganizationModel?> getOrganization(String organizationId) async {
    // Check cache first
    if (_isOrgCacheValid(organizationId)) {
      debugPrint('Organization cache HIT: $organizationId');
      return _organizationCache[organizationId];
    }

    try {
      debugPrint(
          'Organization cache MISS: $organizationId - Fetching from Firestore');

      final doc = await _firestore
          .collection(AppConstants.organizationsCollection)
          .doc(organizationId)
          .get();

      if (doc.exists) {
        final org = OrganizationModel.fromJson(doc.data()!);

        // Update cache
        _organizationCache[organizationId] = org;
        _orgCacheTimestamps[organizationId] = DateTime.now();

        return org;
      } else {
        // Create default organization if not found
        return await _createDefaultOrganization(organizationId);
      }
    } catch (e) {
      debugPrint('Failed to get organization $organizationId: $e');
      // Return cached version if available, even if expired
      return _organizationCache[organizationId];
    }
  }

  // Create default organization for new users
  Future<OrganizationModel> _createDefaultOrganization(
      String organizationId) async {
    final org = OrganizationModel(
      id: organizationId, // REQUIRED
      name: 'Default Organization', // REQUIRED
      description: 'Default organization for individual users',
      logoUrl: null,
      industry: 'Technology', // REQUIRED
      website: null,
      email: null,
      phone: null,
      address: OrganizationAddress(
        // REQUIRED
        street: '',
        city: '',
        state: '',
        country: 'India',
        pincode: '',
      ),
      subscriptionTier: SubscriptionTier.free, // REQUIRED
      settings: <String, dynamic>{
        // REQUIRED
        'maxUsers': 10,
        'maxProjects': 5,
        'features': ['basic_dashboard', 'user_management'],
        'theme': 'default',
        'timezone': 'Asia/Kolkata',
      },
      limits: <String, int>{
        'users': 10,
        'projects': 5,
        'storage': 1024, // 1GB in MB
      },
      isActive: true,
      ownerId: null,
      subscriptionExpiryAt:
          DateTime.now().add(Duration(days: 30)), // 30-day trial
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      await _firestore
          .collection(AppConstants.organizationsCollection)
          .doc(organizationId)
          .set(org.toJson());

      // Cache the new organization
      _organizationCache[organizationId] = org;
      _orgCacheTimestamps[organizationId] = DateTime.now();

      debugPrint('Default organization created: $organizationId');
    } catch (e) {
      debugPrint('Failed to create default organization: $e');
    }

    return org;
  }

  // Update user profile (REQUIRED by providers)
  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> updates) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .update({
        ...updates,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Invalidate cache
      _clearUserCache(userId);

      debugPrint('User profile updated: $userId');
    } catch (e) {
      debugPrint('Failed to update user profile: $e');
      throw Exception('Failed to update user profile: $e');
    }
  }

  // Check if user exists
  Future<bool> userExists(String email) async {
    try {
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } catch (e) {
      return false;
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
      final profile = await getUserProfile(user.uid);
      return profile?.isActive ?? false;
    } catch (e) {
      debugPrint('Session validation failed: $e');
      return false;
    }
  }

  // Cache management methods
  bool _isUserCacheValid(String uid) {
    if (!_userCache.containsKey(uid) ||
        !_userCacheTimestamps.containsKey(uid)) {
      return false;
    }

    final cacheTime = _userCacheTimestamps[uid]!;
    return DateTime.now().difference(cacheTime) < _userCacheTimeout;
  }

  bool _isOrgCacheValid(String orgId) {
    if (!_organizationCache.containsKey(orgId) ||
        !_orgCacheTimestamps.containsKey(orgId)) {
      return false;
    }

    final cacheTime = _orgCacheTimestamps[orgId]!;
    return DateTime.now().difference(cacheTime) < _orgCacheTimeout;
  }

  void _clearUserCache(String uid) {
    _userCache.remove(uid);
    _userCacheTimestamps.remove(uid);
  }

  void _clearOrgCache(String orgId) {
    _organizationCache.remove(orgId);
    _orgCacheTimestamps.remove(orgId);
  }

  void clearAllCache() {
    _userCache.clear();
    _userCacheTimestamps.clear();
    _organizationCache.clear();
    _orgCacheTimestamps.clear();
  }

  // User management methods
  Future<List<UserModel>> getOrganizationUsers(String organizationId) async {
    try {
      final snapshot = await _firestore
          .collection(AppConstants.usersCollection)
          .where('organizationId', isEqualTo: organizationId)
          .get();

      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Failed to get organization users: $e');
      return [];
    }
  }

  Future<void> updateUserRole(String userId, List<String> roles) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .update({
        'roles': roles,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _clearUserCache(userId);
    } catch (e) {
      throw Exception('Failed to update user role: $e');
    }
  }

  Future<void> deactivateUser(String userId) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .update({
        'isActive': false,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _clearUserCache(userId);
    } catch (e) {
      throw Exception('Failed to deactivate user: $e');
    }
  }

  // Analytics and monitoring
  Map<String, dynamic> getAuthStats() {
    return {
      'cached_users': _userCache.length,
      'cached_organizations': _organizationCache.length,
      'active_sessions': currentUser != null ? 1 : 0,
      'last_activity': DateTime.now().toIso8601String(),
      'cache_hit_ratio': _calculateCacheHitRatio(),
    };
  }

  double _calculateCacheHitRatio() {
    final totalCached = _userCache.length + _organizationCache.length;
    if (totalCached == 0) return 0.0;

    // This is a simplified calculation - you might want to track actual hits/misses
    return 0.85; // Placeholder - implement proper tracking if needed
  }

  // Debug methods
  void printCacheStatus() {
    debugPrint('=== AuthService Cache Status ===');
    debugPrint('User Cache: ${_userCache.length} entries');
    debugPrint('Organization Cache: ${_organizationCache.length} entries');
    debugPrint('Current User: ${currentUser?.uid ?? 'None'}');
    debugPrint('===============================');
  }

  // Dispose method for cleanup
  void dispose() {
    clearAllCache();
  }
}
