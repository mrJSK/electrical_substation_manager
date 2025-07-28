// lib/core/widgets/online_operation_guard.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/connectivity_provider.dart';

class OnlineOperationGuard extends ConsumerWidget {
  final Widget child;
  final VoidCallback? onTap;
  final String? offlineMessage;
  final bool showOfflineDialog;

  const OnlineOperationGuard({
    super.key,
    required this.child,
    this.onTap,
    this.offlineMessage,
    this.showOfflineDialog = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider);

    return GestureDetector(
      onTap: () {
        if (isOnline) {
          onTap?.call();
        } else if (showOfflineDialog) {
          _showOfflineDialog(context);
        }
      },
      child: Opacity(
        opacity: isOnline ? 1.0 : 0.6,
        child: child,
      ),
    );
  }

  void _showOfflineDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.wifi_off, color: Colors.red),
        title: const Text('No Internet Connection'),
        content: Text(
          offlineMessage ??
              'This operation requires an internet connection. Please check your network and try again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
