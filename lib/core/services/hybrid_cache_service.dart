import 'package:flutter/foundation.dart';
import 'enhanced_isar_service.dart';

class HybridCacheService {
  // In-memory cache for fastest access
  final Map<String, CacheItem> _memoryCache = {};
  static const int maxMemoryCacheSize = 1000;
  static const Duration defaultCacheDuration = Duration(hours: 1);

  // Three-tier caching: Memory → Isar → Network
  Future<T?> get<T>(
    String key,
    Future<T> Function() networkFetch, {
    Duration? cacheDuration,
    T Function(Map<String, dynamic>)? fromJson,
    Future<void> Function(String, T, Duration)? isarCache,
    Future<T?> Function(String)? isarRetrieve,
  }) async {
    final duration = cacheDuration ?? defaultCacheDuration;

    // Level 1: Memory cache (fastest)
    if (_memoryCache.containsKey(key)) {
      final item = _memoryCache[key]!;
      if (!item.isExpired) {
        debugPrint('Cache HIT (Memory): $key');
        return item.data as T;
      } else {
        _memoryCache.remove(key);
      }
    }

    // Level 2: Isar cache (fast, persistent)
    if (isarRetrieve != null) {
      try {
        final isarResult = await isarRetrieve(key);
        if (isarResult != null) {
          debugPrint('Cache HIT (Isar): $key');
          // Promote to memory cache
          _setInMemoryCache(key, isarResult, duration);
          return isarResult;
        }
      } catch (e) {
        debugPrint('Isar cache retrieval failed for $key: $e');
      }
    }

    // Level 3: Network fetch (slowest)
    debugPrint('Cache MISS: $key - Fetching from network');
    try {
      final networkResult = await networkFetch();

      // Cache in memory
      _setInMemoryCache(key, networkResult, duration);

      // Cache in Isar
      if (isarCache != null) {
        try {
          await isarCache(key, networkResult, duration);
        } catch (e) {
          debugPrint('Isar cache storage failed for $key: $e');
        }
      }

      return networkResult;
    } catch (e) {
      debugPrint('Network fetch failed for $key: $e');
      rethrow;
    }
  }

  void _setInMemoryCache<T>(String key, T value, Duration duration) {
    // Implement LRU eviction if cache is full
    if (_memoryCache.length >= maxMemoryCacheSize) {
      _evictOldestItem();
    }

    _memoryCache[key] = CacheItem(value, DateTime.now().add(duration));
  }

  void _evictOldestItem() {
    if (_memoryCache.isEmpty) return;

    DateTime oldest = DateTime.now();
    String? oldestKey;

    for (final entry in _memoryCache.entries) {
      if (entry.value.createdAt.isBefore(oldest)) {
        oldest = entry.value.createdAt;
        oldestKey = entry.key;
      }
    }

    if (oldestKey != null) {
      _memoryCache.remove(oldestKey);
    }
  }

  // Cache management
  void invalidate(String key) {
    _memoryCache.remove(key);
  }

  void invalidatePattern(String pattern) {
    final regex = RegExp(pattern);
    final keysToRemove =
        _memoryCache.keys.where((key) => regex.hasMatch(key)).toList();

    for (final key in keysToRemove) {
      _memoryCache.remove(key);
    }
  }

  void clear() {
    _memoryCache.clear();
  }

  Map<String, dynamic> getStats() {
    return {
      'memoryCacheSize': _memoryCache.length,
      'maxMemoryCacheSize': maxMemoryCacheSize,
      'memoryUtilization':
          (_memoryCache.length / maxMemoryCacheSize * 100).toStringAsFixed(1) +
              '%',
    };
  }
}

class CacheItem {
  final dynamic data;
  final DateTime expiresAt;
  final DateTime createdAt;

  CacheItem(this.data, this.expiresAt) : createdAt = DateTime.now();

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
