// lib/core/widgets/connectivity_indicator.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/connectivity_provider.dart';
import '../../../core/services/connectivity_service.dart';

class ConnectivityIndicator extends ConsumerWidget {
  final bool showText;
  final IconData? customOnlineIcon;
  final IconData? customOfflineIcon;

  const ConnectivityIndicator({
    super.key,
    this.showText = false,
    this.customOnlineIcon,
    this.customOfflineIcon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityService = ref.watch(connectivityServiceProvider);

    return ListenableBuilder(
      listenable: connectivityService,
      builder: (context, _) {
        final status = connectivityService.status;
        final isOnline = connectivityService.isOnline;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getStatusIcon(status),
              color: _getStatusColor(status),
              size: 16,
            ),
            if (showText) ...[
              const SizedBox(width: 4),
              Text(
                connectivityService.getStatusMessage(),
                style: TextStyle(
                  color: _getStatusColor(status),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  IconData _getStatusIcon(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return customOnlineIcon ?? Icons.wifi;
      case ConnectivityStatus.offline:
        return customOfflineIcon ?? Icons.wifi_off;
      case ConnectivityStatus.checking:
        return Icons.wifi_protected_setup;
    }
  }

  Color _getStatusColor(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return Colors.green;
      case ConnectivityStatus.offline:
        return Colors.red;
      case ConnectivityStatus.checking:
        return Colors.orange;
    }
  }
}
