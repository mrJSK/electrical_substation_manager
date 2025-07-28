import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/connectivity_provider.dart';
import '../../../core/services/connectivity_service.dart';

class OnlineOperationGuard extends ConsumerStatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final String? offlineMessage;
  final bool showTooltip;
  final bool showVisualIndicator;
  final Duration animationDuration;
  final Color? offlineColor;
  final IconData? offlineIcon;
  final bool enableHapticFeedback;
  final bool showDetailedMessage;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const OnlineOperationGuard({
    super.key,
    required this.child,
    this.onTap,
    this.offlineMessage,
    this.showTooltip = true,
    this.showVisualIndicator = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.offlineColor,
    this.offlineIcon,
    this.enableHapticFeedback = true,
    this.showDetailedMessage = false,
    this.padding,
    this.borderRadius,
  });

  @override
  ConsumerState<OnlineOperationGuard> createState() =>
      _OnlineOperationGuardState();
}

class _OnlineOperationGuardState extends ConsumerState<OnlineOperationGuard>
    with TickerProviderStateMixin {
  late AnimationController _opacityController;
  late AnimationController _pulseController;
  late AnimationController _shakeController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shakeAnimation;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _opacityController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.6,
    ).animate(CurvedAnimation(
      parent: _opacityController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.elasticIn,
    ));
  }

  @override
  void dispose() {
    _opacityController.dispose();
    _pulseController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectivity = ref.watch(connectivityServiceProvider);
    final isOnline = connectivity.status == ConnectivityStatus.online;
    final isChecking = connectivity.status == ConnectivityStatus.checking;

    // Control animations based on connectivity status
    _controlAnimations(isOnline, isChecking);

    Widget guardedChild = AnimatedBuilder(
      animation: Listenable.merge(
          [_opacityAnimation, _pulseAnimation, _shakeAnimation]),
      builder: (context, child) {
        return Transform.translate(
          offset: isOnline
              ? Offset.zero
              : Offset(
                  _shakeAnimation.value *
                      2 *
                      ((_shakeAnimation.value * 4).round() % 2 == 0 ? 1 : -1),
                  0),
          child: Transform.scale(
            scale: isChecking ? _pulseAnimation.value : 1.0,
            child: AnimatedOpacity(
              opacity: isOnline ? 1.0 : _opacityAnimation.value,
              duration: widget.animationDuration,
              child: _buildChildWithIndicator(context, isOnline, isChecking),
            ),
          ),
        );
      },
    );

    // Add tooltip for offline state
    if (widget.showTooltip && !isOnline) {
      guardedChild = Tooltip(
        message: _getTooltipMessage(connectivity.status),
        decoration: BoxDecoration(
          color: widget.offlineColor ?? Colors.red.shade700,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        child: guardedChild,
      );
    }

    // Add gesture handling
    if (widget.onTap != null) {
      return GestureDetector(
        onTap: () => _handleTap(context, isOnline, connectivity.status),
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: guardedChild,
        ),
      );
    }

    return guardedChild;
  }

  Widget _buildChildWithIndicator(
      BuildContext context, bool isOnline, bool isChecking) {
    if (!widget.showVisualIndicator) {
      return widget.child;
    }

    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
        border: !isOnline
            ? Border.all(
                color: widget.offlineColor ?? Colors.red.withOpacity(0.3),
                width: 1.5,
              )
            : null,
        boxShadow: !isOnline
            ? [
                BoxShadow(
                  color: (widget.offlineColor ?? Colors.red).withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          widget.child,

          // Offline indicator
          if (!isOnline && widget.showVisualIndicator)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: widget.offlineColor ?? Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(
                  widget.offlineIcon ?? Icons.wifi_off,
                  size: 8,
                  color: Colors.white,
                ),
              ),
            ),

          // Checking indicator
          if (isChecking && widget.showVisualIndicator)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const SizedBox(
                  width: 8,
                  height: 8,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _controlAnimations(bool isOnline, bool isChecking) {
    if (!isOnline) {
      _opacityController.forward();
      _pulseController.stop();
    } else if (isChecking) {
      _opacityController.reverse();
      _pulseController.repeat(reverse: true);
    } else {
      _opacityController.reverse();
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  void _handleTap(
      BuildContext context, bool isOnline, ConnectivityStatus status) {
    if (isOnline) {
      widget.onTap?.call();
    } else {
      // Trigger shake animation for offline tap
      _shakeController.forward().then((_) => _shakeController.reset());

      // Haptic feedback if enabled
      if (widget.enableHapticFeedback) {
        HapticFeedback.lightImpact();
      }

      _showOfflineMessage(context, status);
    }
  }

  String _getTooltipMessage(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.offline:
        return widget.offlineMessage ??
            'Internet connection required for this feature';
      case ConnectivityStatus.checking:
        return 'Checking internet connection...';
      case ConnectivityStatus.online:
        return 'Online - Feature available';
    }
  }

  void _showOfflineMessage(BuildContext context, ConnectivityStatus status) {
    if (widget.showDetailedMessage) {
      _showDetailedOfflineDialog(context, status);
    } else {
      _showOfflineSnackbar(context, status);
    }
  }

  void _showOfflineSnackbar(BuildContext context, ConnectivityStatus status) {
    final message = _getOfflineMessage(status);
    final icon = _getStatusIcon(status);
    final color = _getStatusColor(status);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  if (status == ConnectivityStatus.offline)
                    const Text(
                      'Check your internet connection and try again',
                      style: TextStyle(fontSize: 12),
                    ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        action: status == ConnectivityStatus.offline
            ? SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () {
                  ref.read(connectivityServiceProvider).checkConnectivity();
                },
              )
            : null,
      ),
    );
  }

  void _showDetailedOfflineDialog(
      BuildContext context, ConnectivityStatus status) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              _getStatusIcon(status),
              color: _getStatusColor(status),
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              _getDialogTitle(status),
              style: TextStyle(
                color: _getStatusColor(status),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getDetailedMessage(status),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Some features may work offline with cached data.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
          if (status == ConnectivityStatus.offline)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ref.read(connectivityServiceProvider).checkConnectivity();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Check Connection'),
            ),
        ],
      ),
    );
  }

  String _getOfflineMessage(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.offline:
        return widget.offlineMessage ?? 'Feature unavailable offline';
      case ConnectivityStatus.checking:
        return 'Checking connection...';
      case ConnectivityStatus.online:
        return 'Online';
    }
  }

  String _getDialogTitle(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.offline:
        return 'No Internet Connection';
      case ConnectivityStatus.checking:
        return 'Checking Connection';
      case ConnectivityStatus.online:
        return 'Connected';
    }
  }

  String _getDetailedMessage(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.offline:
        return 'This feature requires an active internet connection to function properly. Please check your network settings and try again.';
      case ConnectivityStatus.checking:
        return 'We\'re currently checking your internet connection. Please wait a moment and try again.';
      case ConnectivityStatus.online:
        return 'You\'re connected to the internet. All features are available.';
    }
  }

  IconData _getStatusIcon(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.offline:
        return Icons.wifi_off;
      case ConnectivityStatus.checking:
        return Icons.wifi_find;
      case ConnectivityStatus.online:
        return Icons.wifi;
    }
  }

  Color _getStatusColor(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.offline:
        return widget.offlineColor ?? Colors.red;
      case ConnectivityStatus.checking:
        return Colors.orange;
      case ConnectivityStatus.online:
        return Colors.green;
    }
  }
}

// Specialized variants for different use cases
class OnlineActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final String? offlineMessage;
  final ButtonStyle? style;

  const OnlineActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.offlineMessage,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return OnlineOperationGuard(
      onTap: onPressed,
      offlineMessage: offlineMessage,
      showDetailedMessage: true,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    );
  }
}

class OnlineIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final String? tooltip;
  final String? offlineMessage;

  const OnlineIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
    this.offlineMessage,
  });

  @override
  Widget build(BuildContext context) {
    return OnlineOperationGuard(
      onTap: onPressed,
      offlineMessage: offlineMessage ?? tooltip,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        tooltip: tooltip,
      ),
    );
  }
}

class OnlineFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final String? tooltip;
  final String? offlineMessage;
  final Color? backgroundColor;

  const OnlineFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.tooltip,
    this.offlineMessage,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return OnlineOperationGuard(
      onTap: onPressed,
      offlineMessage: offlineMessage ?? tooltip,
      showDetailedMessage: true,
      child: FloatingActionButton(
        onPressed: onPressed,
        tooltip: tooltip,
        backgroundColor: backgroundColor,
        child: child,
      ),
    );
  }
}

// Mixin for easy integration with existing widgets
mixin OnlineOperationMixin<T extends StatefulWidget> on State<T> {
  bool get isOnline {
    // This would need to be implemented with proper provider access
    return true; // Placeholder
  }

  void guardOnlineOperation(VoidCallback operation, {String? offlineMessage}) {
    if (isOnline) {
      operation();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              offlineMessage ?? 'This feature requires internet connection'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }
}
