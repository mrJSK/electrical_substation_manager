import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

enum ConnectivityStatus {
  online,
  offline,
  checking,
}

class ConnectivityService extends ChangeNotifier {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  ConnectivityStatus _status = ConnectivityStatus.checking;

  // Stream controller for status changes
  final StreamController<ConnectivityStatus> _statusController =
      StreamController<ConnectivityStatus>.broadcast();

  ConnectivityStatus get status => _status;
  bool get isOnline => _status == ConnectivityStatus.online;
  bool get isOffline => _status == ConnectivityStatus.offline;

  // Expose status as stream
  Stream<ConnectivityStatus> get statusStream => _statusController.stream;

  // Initialize connectivity monitoring
  Future<void> initialize() async {
    // Check initial connectivity
    final results = await _connectivity.checkConnectivity();
    _updateStatus(results);

    // Listen for connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateStatus,
      onError: (error) {
        debugPrint('Connectivity error: $error');
        _status = ConnectivityStatus.offline;
        notifyListeners();
        _statusController.add(_status);
      },
    );
  }

  // Updated to handle List<ConnectivityResult>
  void _updateStatus(List<ConnectivityResult> results) {
    // Check if any connection type is available (not none)
    final hasConnection =
        results.any((result) => result != ConnectivityResult.none);

    final newStatus =
        hasConnection ? ConnectivityStatus.online : ConnectivityStatus.offline;

    if (_status != newStatus) {
      _status = newStatus;
      notifyListeners();
      _statusController.add(_status);
      // Log connectivity changes with connection types
      debugPrint('Connectivity changed to: $_status (${results.join(', ')})');
    }
  }

  // Dispose resources
  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _statusController.close();
    super.dispose();
  }

  // Check if specific operations should be allowed
  bool canPerformOnlineOperation() {
    return isOnline;
  }

  // Get user-friendly status message
  String getStatusMessage() {
    switch (_status) {
      case ConnectivityStatus.online:
        return 'Connected';
      case ConnectivityStatus.offline:
        return 'No internet connection';
      case ConnectivityStatus.checking:
        return 'Checking connection...';
    }
  }

  // Force connectivity check
  Future<void> checkConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    _updateStatus(results);
  }

  // Get detailed connection info
  Future<List<ConnectivityResult>> getConnectionTypes() async {
    return await _connectivity.checkConnectivity();
  }

  // Check if specific connection type is available
  Future<bool> hasConnectionType(ConnectivityResult type) async {
    final results = await _connectivity.checkConnectivity();
    return results.contains(type);
  }

  // Get connection type as string for display
  String get connectionType {
    // This would need to be implemented based on current connection types
    // For now, return a simple status
    return isOnline ? 'Connected' : 'Disconnected';
  }

  // Additional utility methods
  Future<bool> waitForConnection(
      {Duration timeout = const Duration(seconds: 30)}) async {
    if (isOnline) return true;

    final completer = Completer<bool>();
    late StreamSubscription subscription;

    subscription = statusStream.listen((status) {
      if (status == ConnectivityStatus.online) {
        subscription.cancel();
        if (!completer.isCompleted) {
          completer.complete(true);
        }
      }
    });

    // Set timeout
    Timer(timeout, () {
      subscription.cancel();
      if (!completer.isCompleted) {
        completer.complete(false);
      }
    });

    return completer.future;
  }

  // Get network strength (placeholder - would need platform-specific implementation)
  Future<int> getNetworkStrength() async {
    // Return a value between 0-100 representing network strength
    // This would need platform-specific implementation
    return isOnline ? 75 : 0;
  }
}
