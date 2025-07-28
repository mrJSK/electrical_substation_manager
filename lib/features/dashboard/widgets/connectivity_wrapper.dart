// lib/core/widgets/connectivity_wrapper.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/connectivity_provider.dart';
import '../../../core/services/connectivity_service.dart';

class ConnectivityWrapper extends ConsumerWidget {
  final Widget child;
  final bool showBanner;
  final VoidCallback? onRetry;

  const ConnectivityWrapper({
    super.key,
    required this.child,
    this.showBanner = true,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityService = ref.watch(connectivityServiceProvider);

    return ListenableBuilder(
      listenable: connectivityService,
      builder: (context, _) {
        return Column(
          children: [
            if (showBanner && connectivityService.isOffline)
              _buildOfflineBanner(context, connectivityService),
            Expanded(child: child),
          ],
        );
      },
    );
  }

  Widget _buildOfflineBanner(
      BuildContext context, ConnectivityService service) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.red.shade600,
      child: Row(
        children: [
          const Icon(Icons.wifi_off, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'No internet connection',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await service.checkConnectivity();
              onRetry?.call();
            },
            child: const Text(
              'RETRY',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
