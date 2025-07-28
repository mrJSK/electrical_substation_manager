// lib/core/services/connectivity_service.dart
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
  StreamSubscription<List<ConnectivityResult>>?
      _connectivitySubscription; // Updated type

  ConnectivityStatus _status = ConnectivityStatus.checking;
  ConnectivityStatus get status => _status;

  bool get isOnline => _status == ConnectivityStatus.online;
  bool get isOffline => _status == ConnectivityStatus.offline;

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

      // Log connectivity changes with connection types
      debugPrint('Connectivity changed to: $_status (${results.join(', ')})');
    }
  }

  // Dispose resources
  @override
  void dispose() {
    _connectivitySubscription?.cancel();
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

  // Get detailed connection info (optional enhancement)
  Future<List<ConnectivityResult>> getConnectionTypes() async {
    return await _connectivity.checkConnectivity();
  }

  // Check if specific connection type is available
  Future<bool> hasConnectionType(ConnectivityResult type) async {
    final results = await _connectivity.checkConnectivity();
    return results.contains(type);
  }
}
