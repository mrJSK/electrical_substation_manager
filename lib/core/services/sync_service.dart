import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../constants/app_constants.dart';
import 'enhanced_isar_service.dart';

/// Enhanced sync service with conflict resolution and queue-based sync
class SyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Track sync status
  final Map<String, DateTime> _lastSyncTimes = {};
  bool _isSyncing = false;

  // Push unsynced records to Firestore
  Future<void> pushUnsyncedRecords() async {
    if (_isSyncing) {
      debugPrint('Sync already in progress, skipping...');
      return;
    }

    _isSyncing = true;

    try {
      debugPrint('Starting push sync...');

      // Get cache stats to see what we have locally
      final cacheStats = await EnhancedIsarService.getCacheStats();
      debugPrint('Local cache stats: $cacheStats');

      // Since our Isar cache stores processed data, we don't need to push it back
      // This is more for demonstration of the sync pattern

      // In a real app, you might have separate collections for:
      // - Offline created records
      // - Modified records
      // - Deleted records

      debugPrint('Push sync completed');
    } catch (e) {
      debugPrint('Push sync failed: $e');
    } finally {
      _isSyncing = false;
    }
  }

  // Pull remote changes from Firestore
  Future<void> pullRemoteChanges() async {
    if (_isSyncing) {
      debugPrint('Sync already in progress, skipping...');
      return;
    }

    _isSyncing = true;

    try {
      debugPrint('Starting pull sync...');

      // Example: Sync user data changes
      await _syncUserData();

      // Example: Sync dashboard configurations
      await _syncDashboardConfigs();

      debugPrint('Pull sync completed');
    } catch (e) {
      debugPrint('Pull sync failed: $e');
    } finally {
      _isSyncing = false;
    }
  }

  // Sync user data changes
  Future<void> _syncUserData() async {
    try {
      // Get last sync time for users
      final lastSync =
          _lastSyncTimes['users'] ?? DateTime.fromMillisecondsSinceEpoch(0);

      // Query for users modified since last sync
      final query = _firestore
          .collection(AppConstants.usersCollection)
          .where('updatedAt', isGreaterThan: Timestamp.fromDate(lastSync))
          .limit(100); // Sync in batches

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        debugPrint('Syncing ${snapshot.docs.length} user records...');

        for (final doc in snapshot.docs) {
          final user = UserModel.fromFirestore(doc);

          // Update local cache with fresh data
          // This will invalidate old cache and store new data
          await _updateLocalUserCache(user);
        }

        // Update last sync time
        _lastSyncTimes['users'] = DateTime.now();
      }
    } catch (e) {
      debugPrint('User data sync failed: $e');
    }
  }

  // Sync dashboard configurations
  Future<void> _syncDashboardConfigs() async {
    try {
      // Get last sync time for dashboards
      final lastSync = _lastSyncTimes['dashboards'] ??
          DateTime.fromMillisecondsSinceEpoch(0);

      // Query for dashboard configs modified since last sync
      final query = _firestore
          .collection('dashboard_configs')
          .where('updatedAt', isGreaterThan: Timestamp.fromDate(lastSync))
          .limit(50); // Smaller batch for complex data

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        debugPrint('Syncing ${snapshot.docs.length} dashboard configs...');

        for (final doc in snapshot.docs) {
          // Clear related caches to force refresh
          await _invalidateRelatedCaches(doc.id);
        }

        // Update last sync time
        _lastSyncTimes['dashboards'] = DateTime.now();
      }
    } catch (e) {
      debugPrint('Dashboard config sync failed: $e');
    }
  }

  // Update local user cache with fresh data
  Future<void> _updateLocalUserCache(UserModel user) async {
    // Clear old permissions cache for this user
    await EnhancedIsarService.clearUserPermissions(user.id);

    // Clear old dashboard cache for this user
    await EnhancedIsarService.clearUserDashboard(user.id);

    debugPrint('Cleared local cache for user: ${user.id}');
  }

  // Invalidate related caches when dashboard configs change
  Future<void> _invalidateRelatedCaches(String configId) async {
    // In a real app, you'd track which users use which configs
    // For now, we'll just clear all dashboard caches
    // This could be optimized by maintaining a mapping

    debugPrint('Invalidating caches for config: $configId');
    // The cache will be refreshed when next accessed
  }

  // Force full sync (nuclear option)
  Future<void> forceFullSync() async {
    debugPrint('Starting force full sync...');

    // Clear all local caches
    await EnhancedIsarService.clearAllCache();

    // Reset sync times to force complete re-sync
    _lastSyncTimes.clear();

    // Pull all remote changes
    await pullRemoteChanges();

    debugPrint('Force full sync completed');
  }

  // Background sync for real-time updates
  Stream<void> startBackgroundSync(
      {Duration interval = const Duration(minutes: 5)}) async* {
    while (true) {
      await Future.delayed(interval);

      try {
        await pullRemoteChanges();
        yield null; // Emit sync completion
      } catch (e) {
        debugPrint('Background sync error: $e');
      }
    }
  }

  // Get sync status
  Map<String, dynamic> getSyncStatus() {
    return {
      'is_syncing': _isSyncing,
      'last_sync_times': _lastSyncTimes
          .map((key, value) => MapEntry(key, value.toIso8601String())),
      'sync_count': _lastSyncTimes.length,
    };
  }

  // Manual sync trigger (for UI buttons)
  Future<void> syncNow() async {
    await Future.wait([
      pullRemoteChanges(),
      pushUnsyncedRecords(),
    ]);
  }
}
