// lib/providers/connectivity_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../services/network_service.dart';

part 'connectivity_provider.g.dart';

@riverpod
class ConnectivityNotifier extends _$ConnectivityNotifier {
  @override
  bool build() {
    _listenToConnectivity();
    return true; // Assume connected initially
  }

  void _listenToConnectivity() {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      final hasNetworkConnection = result.any((element) =>
          element == ConnectivityResult.mobile ||
          element == ConnectivityResult.wifi ||
          element == ConnectivityResult.ethernet);

      if (hasNetworkConnection) {
        // Double-check with actual internet connectivity
        final hasInternet = await NetworkService.hasInternetConnection();
        if (state != hasInternet) {
          state = hasInternet;
        }
      } else {
        if (state != false) {
          state = false;
        }
      }
    });
  }

  void updateStatus(bool isConnected) {
    state = isConnected;
  }
}

// Helper provider to get connectivity status
@riverpod
bool isConnected(IsConnectedRef ref) {
  return ref.watch(connectivityNotifierProvider);
}
