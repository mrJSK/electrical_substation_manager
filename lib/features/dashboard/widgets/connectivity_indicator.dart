import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/connectivity_provider.dart';
import '../../../core/services/connectivity_service.dart';

class ConnectivityIndicator extends ConsumerStatefulWidget {
  final bool showText;
  final bool showTooltip;
  final Color? onlineColor;
  final Color? offlineColor;
  final Color? checkingColor;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;
  final double? fontSize;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool animated;
  final Duration animationDuration;

  const ConnectivityIndicator({
    super.key,
    this.showText = false,
    this.showTooltip = true,
    this.onlineColor,
    this.offlineColor,
    this.checkingColor,
    this.padding,
    this.iconSize = 16,
    this.fontSize = 12,
    this.borderRadius,
    this.onTap,
    this.animated = true,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  ConsumerState<ConnectivityIndicator> createState() =>
      _ConnectivityIndicatorState();
}

class _ConnectivityIndicatorState extends ConsumerState<ConnectivityIndicator>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    // Pulse animation for checking state
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Rotation animation for checking state
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectivity = ref.watch(connectivityServiceProvider);

    // Control animations based on connectivity status
    _controlAnimations(connectivity.status);

    final indicator = _buildIndicator(context, connectivity);

    return widget.showTooltip
        ? Tooltip(
            message: _getTooltipMessage(connectivity.status),
            child: indicator,
          )
        : indicator;
  }

  Widget _buildIndicator(
      BuildContext context, ConnectivityService connectivity) {
    final status = connectivity.status;

    Widget child = AnimatedBuilder(
      animation: Listenable.merge(
          [_pulseAnimation, _rotationAnimation, _scaleAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: status == ConnectivityStatus.checking && widget.animated
              ? _scaleAnimation.value
              : 1.0,
          child: AnimatedContainer(
            duration:
                widget.animated ? widget.animationDuration : Duration.zero,
            padding: widget.padding ??
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getBackgroundColor(status),
              borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
              boxShadow: [
                if (status == ConnectivityStatus.offline)
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: 4,
                    spreadRadius: 1,
                  )
                else if (status == ConnectivityStatus.online)
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    blurRadius: 2,
                    spreadRadius: 0.5,
                  ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildIcon(status),
                if (widget.showText) ...[
                  const SizedBox(width: 6),
                  _buildText(status),
                ],
              ],
            ),
          ),
        );
      },
    );

    // Add tap functionality if provided
    if (widget.onTap != null) {
      child = InkWell(
        onTap: widget.onTap,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
        child: child,
      );
    }

    return child;
  }

  Widget _buildIcon(ConnectivityStatus status) {
    Widget icon = Icon(
      _getIcon(status),
      size: widget.iconSize,
      color: Colors.white,
    );

    // Apply rotation animation for checking status
    if (status == ConnectivityStatus.checking && widget.animated) {
      icon = AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value * 2 * 3.14159,
            child: icon,
          );
        },
      );
    }

    // Apply pulse animation for checking status
    if (status == ConnectivityStatus.checking && widget.animated) {
      icon = AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pulseAnimation.value,
            child: icon,
          );
        },
      );
    }

    return icon;
  }

  Widget _buildText(ConnectivityStatus status) {
    return AnimatedDefaultTextStyle(
      duration: widget.animated ? widget.animationDuration : Duration.zero,
      style: TextStyle(
        color: Colors.white,
        fontSize: widget.fontSize,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      child: Text(_getText(status)),
    );
  }

  void _controlAnimations(ConnectivityStatus status) {
    if (!widget.animated) return;

    switch (status) {
      case ConnectivityStatus.checking:
        if (!_pulseController.isAnimating) {
          _pulseController.repeat(reverse: true);
        }
        if (!_rotationController.isAnimating) {
          _rotationController.repeat();
        }
        break;
      case ConnectivityStatus.online:
      case ConnectivityStatus.offline:
        _pulseController.stop();
        _rotationController.stop();
        _pulseController.reset();
        _rotationController.reset();
        break;
    }
  }

  Color _getBackgroundColor(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return widget.onlineColor ?? const Color(0xFF4CAF50);
      case ConnectivityStatus.offline:
        return widget.offlineColor ?? const Color(0xFFE53935);
      case ConnectivityStatus.checking:
        return widget.checkingColor ?? const Color(0xFFFF9800);
    }
  }

  IconData _getIcon(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return Icons.wifi;
      case ConnectivityStatus.offline:
        return Icons.wifi_off;
      case ConnectivityStatus.checking:
        return Icons.wifi_find;
    }
  }

  String _getText(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return 'Online';
      case ConnectivityStatus.offline:
        return 'Offline';
      case ConnectivityStatus.checking:
        return 'Checking...';
    }
  }

  String _getTooltipMessage(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return 'Connected to internet';
      case ConnectivityStatus.offline:
        return 'No internet connection\nSome features may be limited';
      case ConnectivityStatus.checking:
        return 'Checking internet connection...';
    }
  }
}

// Enhanced version with detailed connectivity info
class DetailedConnectivityIndicator extends ConsumerWidget {
  final bool showConnectionType;
  final bool showSignalStrength;
  final VoidCallback? onTap;

  const DetailedConnectivityIndicator({
    super.key,
    this.showConnectionType = false,
    this.showSignalStrength = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityServiceProvider);

    return GestureDetector(
      onTap: onTap ?? () => _showConnectivityDetails(context, connectivity),
      child: Card(
        margin: const EdgeInsets.all(4),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConnectivityIndicator(
                    showText: true,
                    iconSize: 18,
                    fontSize: 12,
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.info_outline,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
              if (showConnectionType || showSignalStrength) ...[
                const SizedBox(height: 4),
                _buildAdditionalInfo(connectivity),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo(ConnectivityService connectivity) {
    return Text(
      _getAdditionalInfo(connectivity),
      style: TextStyle(
        fontSize: 10,
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  String _getAdditionalInfo(ConnectivityService connectivity) {
    final parts = <String>[];

    if (showConnectionType) {
      parts.add('WiFi'); // Simplified - you can enhance this
    }

    if (showSignalStrength) {
      parts.add('Strong'); // Simplified - you can enhance this
    }

    return parts.join(' • ');
  }

  void _showConnectivityDetails(
      BuildContext context, ConnectivityService connectivity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            ConnectivityIndicator(showText: false, iconSize: 20),
            const SizedBox(width: 12),
            const Text('Connectivity Status'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Status', connectivity.getStatusMessage()),
            const SizedBox(height: 8),
            _buildDetailRow('Connection Type', 'WiFi/Mobile Data'),
            const SizedBox(height: 8),
            _buildDetailRow('Signal Strength', 'Strong'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: connectivity.isOnline
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    connectivity.isOnline ? Icons.check_circle : Icons.error,
                    color: connectivity.isOnline ? Colors.green : Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      connectivity.isOnline
                          ? 'All features are available'
                          : 'Some features may be limited offline',
                      style: TextStyle(
                        fontSize: 12,
                        color: connectivity.isOnline
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          if (!connectivity.isOnline)
            TextButton(
              onPressed: () async {
                await connectivity.checkConnectivity();
                Navigator.pop(context);
              },
              child: const Text('Retry'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

// Compact version for minimal space usage
class CompactConnectivityIndicator extends ConsumerWidget {
  final double size;
  final VoidCallback? onTap;

  const CompactConnectivityIndicator({
    super.key,
    this.size = 20,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityServiceProvider);

    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: connectivity.getStatusMessage(),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: _getStatusColor(connectivity.status),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _getStatusColor(connectivity.status).withOpacity(0.3),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Icon(
            _getStatusIcon(connectivity.status),
            size: size * 0.6,
            color: Colors.white,
          ),
        ),
      ),
    );
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

  IconData _getStatusIcon(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return Icons.check;
      case ConnectivityStatus.offline:
        return Icons.close;
      case ConnectivityStatus.checking:
        return Icons.more_horiz;
    }
  }
}

// Banner version for full-width notifications
class ConnectivityBanner extends ConsumerWidget {
  final Widget child;
  final bool showWhenOnline;
  final Duration animationDuration;

  const ConnectivityBanner({
    super.key,
    required this.child,
    this.showWhenOnline = false,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityServiceProvider);
    final shouldShow = connectivity.isOffline ||
        (showWhenOnline && connectivity.isOnline) ||
        connectivity.status == ConnectivityStatus.checking;

    return Column(
      children: [
        AnimatedContainer(
          duration: animationDuration,
          height: shouldShow ? 40 : 0,
          child: AnimatedOpacity(
            opacity: shouldShow ? 1.0 : 0.0,
            duration: animationDuration,
            child: Container(
              width: double.infinity,
              color: _getBannerColor(connectivity.status),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getBannerIcon(connectivity.status),
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _getBannerMessage(connectivity.status),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }

  Color _getBannerColor(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return Colors.green;
      case ConnectivityStatus.offline:
        return Colors.red;
      case ConnectivityStatus.checking:
        return Colors.orange;
    }
  }

  IconData _getBannerIcon(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return Icons.wifi;
      case ConnectivityStatus.offline:
        return Icons.wifi_off;
      case ConnectivityStatus.checking:
        return Icons.wifi_find;
    }
  }

  String _getBannerMessage(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return 'Connected to internet';
      case ConnectivityStatus.offline:
        return 'No internet connection - Some features may be limited';
      case ConnectivityStatus.checking:
        return 'Checking internet connection...';
    }
  }
}
