// lib/widgets/connectivity_listener.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/connectivity_provider.dart';

class ConnectivityListener extends ConsumerStatefulWidget {
  final Widget child;

  const ConnectivityListener({super.key, required this.child});

  @override
  ConsumerState<ConnectivityListener> createState() =>
      _ConnectivityListenerState();
}

class _ConnectivityListenerState extends ConsumerState<ConnectivityListener> {
  bool _wasOffline = false;
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
      _snackBarController;

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(connectivityNotifierProvider, (previous, next) {
      _handleConnectivityChange(next);
    });

    return widget.child;
  }

  void _handleConnectivityChange(bool isConnected) {
    if (!isConnected && !_wasOffline) {
      // Connection lost
      _wasOffline = true;
      _showOfflineSnackBar();
    } else if (isConnected && _wasOffline) {
      // Connection restored
      _wasOffline = false;
      _dismissOfflineSnackBar();
      _showOnlineSnackBar();
    }
  }

  void _showOfflineSnackBar() {
    _dismissOfflineSnackBar(); // Dismiss any existing snackbar

    _snackBarController = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.wifi_off, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'No internet connection. Please check your network.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        duration: const Duration(days: 1), // Persistent until dismissed
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: () {
            // Force check connectivity
            ref.read(connectivityNotifierProvider.notifier).updateStatus(true);
          },
        ),
      ),
    );
  }

  void _showOnlineSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.wifi, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'Connection restored!',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _dismissOfflineSnackBar() {
    _snackBarController?.close();
    _snackBarController = null;
  }

  @override
  void dispose() {
    _dismissOfflineSnackBar();
    super.dispose();
  }
}
