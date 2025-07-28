import 'package:flutter/foundation.dart';
import 'connectivity_service.dart';

// Abstract operation interface for LSP compliance
abstract class NetworkOperation<T> {
  Future<T> execute();
  T? getOfflineFallback();
  bool requiresNetwork();
  String get operationName;
}

class OnlineOperation<T> implements NetworkOperation<T> {
  final Future<T> Function() _operation;
  final T? _fallback;
  final String _operationName;

  OnlineOperation(this._operation, this._operationName, {T? fallback})
      : _fallback = fallback;

  @override
  Future<T> execute() => _operation();

  @override
  T? getOfflineFallback() => _fallback;

  @override
  bool requiresNetwork() => true;

  @override
  String get operationName => _operationName;
}

class OfflineOperation<T> implements NetworkOperation<T> {
  final Future<T> Function() _operation;
  final String _operationName;

  OfflineOperation(this._operation, this._operationName);

  @override
  Future<T> execute() => _operation();

  @override
  T? getOfflineFallback() => null;

  @override
  bool requiresNetwork() => false;

  @override
  String get operationName => _operationName;
}

mixin NetworkAwareService {
  ConnectivityService get _connectivity => ConnectivityService();

  Future<T> executeOperation<T>(NetworkOperation<T> operation) async {
    if (operation.requiresNetwork() && !_connectivity.isOnline) {
      debugPrint('Skipping ${operation.operationName} - device is offline');

      final fallback = operation.getOfflineFallback();
      if (fallback != null) {
        return fallback;
      }

      throw NetworkException(
          '${operation.operationName} requires internet connection');
    }

    try {
      return await operation.execute();
    } catch (e) {
      debugPrint('${operation.operationName} failed: $e');

      if (operation.requiresNetwork()) {
        final fallback = operation.getOfflineFallback();
        if (fallback != null) {
          debugPrint('Using fallback for ${operation.operationName}');
          return fallback;
        }
      }

      rethrow;
    }
  }

  // Convenience method for simple online operations
  Future<T> executeOnlineOperation<T>(
    Future<T> Function() operation, {
    T? fallback,
    required String operationName,
  }) async {
    final networkOp =
        OnlineOperation<T>(operation, operationName, fallback: fallback);
    return executeOperation(networkOp);
  }

  // Convenience method for offline operations
  Future<T> executeOfflineOperation<T>(
    Future<T> Function() operation, {
    required String operationName,
  }) async {
    final networkOp = OfflineOperation<T>(operation, operationName);
    return executeOperation(networkOp);
  }

  bool canPerformOperation() {
    return _connectivity.isOnline;
  }

  // Batch operations with partial success handling
  Future<Map<String, T?>> executeBatchOperations<T>(
      Map<String, NetworkOperation<T>> operations) async {
    final results = <String, T?>{};
    final futures = <String, Future<T>>{};

    // Start all operations
    for (final entry in operations.entries) {
      if (!entry.value.requiresNetwork() || _connectivity.isOnline) {
        futures[entry.key] = entry.value.execute();
      } else {
        results[entry.key] = entry.value.getOfflineFallback();
      }
    }

    // Wait for all online operations
    final completedOperations =
        await FutureExtensions.allSettled(futures.values);
    int index = 0;

    for (final key in futures.keys) {
      final result = completedOperations[index++];
      if (result.hasValue) {
        results[key] = result.value;
      } else {
        results[key] = operations[key]?.getOfflineFallback();
      }
    }

    return results;
  }
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

// Extension for Future.allSettled equivalent
class FutureExtensions {
  static Future<List<AsyncValue<T>>> allSettled<T>(
      Iterable<Future<T>> futures) async {
    return await Future.wait(
      futures.map((future) async {
        try {
          final value = await future;
          return AsyncValue.data(value);
        } catch (error, stackTrace) {
          return AsyncValue.error(error, stackTrace);
        }
      }),
    );
  }
}

// Simple AsyncValue implementation
abstract class AsyncValue<T> {
  const AsyncValue();

  factory AsyncValue.data(T value) = AsyncData<T>;
  factory AsyncValue.error(Object error, StackTrace stackTrace) = AsyncError<T>;

  bool get hasValue;
  T get value;
  Object get error;
}

class AsyncData<T> extends AsyncValue<T> {
  final T _value;
  const AsyncData(this._value);

  @override
  bool get hasValue => true;

  @override
  T get value => _value;

  @override
  Object get error => throw StateError('AsyncData has no error');
}

class AsyncError<T> extends AsyncValue<T> {
  final Object _error;
  final StackTrace _stackTrace;

  const AsyncError(this._error, this._stackTrace);

  @override
  bool get hasValue => false;

  @override
  T get value => throw StateError('AsyncError has no value');

  @override
  Object get error => _error;
}
