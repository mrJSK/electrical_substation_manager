import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/connectivity_provider.dart';
import '../../../core/services/connectivity_service.dart';

class ConnectivityWrapper extends ConsumerStatefulWidget {
  final Widget child;
  final bool showBanner;
  final bool showOnlineReconnectedMessage;
  final Duration bannerAnimationDuration;
  final EdgeInsetsGeometry? bannerPadding;
  final TextStyle? bannerTextStyle;
  final VoidCallback? onRetry;
  final bool allowDismissBanner;
  final Duration dismissTimeout;

  const ConnectivityWrapper({
    super.key,
    required this.child,
    this.showBanner = true,
    this.showOnlineReconnectedMessage = true,
    this.bannerAnimationDuration = const Duration(milliseconds: 300),
    this.bannerPadding,
    this.bannerTextStyle,
    this.onRetry,
    this.allowDismissBanner = false,
    this.dismissTimeout = const Duration(seconds: 5),
  });

  @override
  ConsumerState<ConnectivityWrapper> createState() =>
      _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends ConsumerState<ConnectivityWrapper>
    with TickerProviderStateMixin {
  late AnimationController _bannerAnimationController;
  late AnimationController _pulseAnimationController;
  late Animation<double> _bannerSlideAnimation;
  late Animation<double> _bannerFadeAnimation;
  late Animation<double> _pulseAnimation;

  ConnectivityStatus? _previousStatus;
  bool _showReconnectedMessage = false;
  bool _bannerDismissed = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _bannerAnimationController = AnimationController(
      duration: widget.bannerAnimationDuration,
      vsync: this,
    );

    _pulseAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _bannerSlideAnimation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _bannerAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _bannerFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bannerAnimationController,
      curve: Curves.easeOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _bannerAnimationController.dispose();
    _pulseAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectivity = ref.watch(connectivityServiceProvider);

    // Handle status changes and animations
    _handleStatusChange(connectivity.status);

    if (!widget.showBanner) {
      return widget.child;
    }

    return Scaffold(
      body: Column(
        children: [
          _buildConnectivityBanner(connectivity),
          Expanded(child: widget.child),
        ],
      ),
    );
  }

  Widget _buildConnectivityBanner(ConnectivityService connectivity) {
    final status = connectivity.status;
    final shouldShowBanner = _shouldShowBanner(status);

    return AnimatedBuilder(
      animation: _bannerAnimationController,
      builder: (context, child) {
        return AnimatedContainer(
          duration: widget.bannerAnimationDuration,
          height: shouldShowBanner ? 50 : 0,
          child: AnimatedOpacity(
            opacity: shouldShowBanner ? 1.0 : 0.0,
            duration: widget.bannerAnimationDuration,
            child: Transform.translate(
              offset: Offset(0, _bannerSlideAnimation.value * 50),
              child: FadeTransition(
                opacity: _bannerFadeAnimation,
                child: _buildBannerContent(status),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBannerContent(ConnectivityStatus status) {
    final bannerData = _getBannerData(status);

    return Container(
      width: double.infinity,
      padding: widget.bannerPadding ??
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
      decoration: BoxDecoration(
        color: bannerData['color'] as Color,
        boxShadow: [
          BoxShadow(
            color: (bannerData['color'] as Color).withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            _buildBannerIcon(status),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    bannerData['title'] as String,
                    style: widget.bannerTextStyle?.copyWith(
                          fontWeight: FontWeight.w600,
                        ) ??
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (bannerData['subtitle'] != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      bannerData['subtitle'] as String,
                      style: widget.bannerTextStyle?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ) ??
                          const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            _buildBannerActions(status),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerIcon(ConnectivityStatus status) {
    Widget icon = Icon(
      _getBannerIconData(status),
      color: Colors.white,
      size: 20,
    );

    // Add pulse animation for checking status
    if (status == ConnectivityStatus.checking) {
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

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: icon,
    );
  }

  Widget _buildBannerActions(ConnectivityStatus status) {
    final actions = <Widget>[];

    // Retry button for offline status
    if (status == ConnectivityStatus.offline) {
      actions.add(
        TextButton.icon(
          onPressed: widget.onRetry ?? () => _handleRetry(),
          icon: const Icon(Icons.refresh, color: Colors.white, size: 16),
          label: const Text(
            'Retry',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            minimumSize: Size.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      );
    }

    // Dismiss button if allowed
    if (widget.allowDismissBanner && status != ConnectivityStatus.checking) {
      actions.add(
        IconButton(
          onPressed: _dismissBanner,
          icon: const Icon(Icons.close, color: Colors.white70, size: 16),
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
          tooltip: 'Dismiss',
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: actions.map((action) {
        return Padding(
          padding: const EdgeInsets.only(left: 8),
          child: action,
        );
      }).toList(),
    );
  }

  void _handleStatusChange(ConnectivityStatus currentStatus) {
    // Detect status changes
    if (_previousStatus != currentStatus) {
      _bannerDismissed = false; // Reset dismissal on status change

      // Handle reconnection message
      if (_previousStatus == ConnectivityStatus.offline &&
          currentStatus == ConnectivityStatus.online &&
          widget.showOnlineReconnectedMessage) {
        _showReconnectedMessage = true;
        _startReconnectedMessageTimer();
      } else {
        _showReconnectedMessage = false;
      }

      // Control animations
      if (_shouldShowBanner(currentStatus)) {
        _bannerAnimationController.forward();

        if (currentStatus == ConnectivityStatus.checking) {
          _pulseAnimationController.repeat(reverse: true);
        } else {
          _pulseAnimationController.stop();
          _pulseAnimationController.reset();
        }
      } else {
        _bannerAnimationController.reverse();
        _pulseAnimationController.stop();
        _pulseAnimationController.reset();
      }

      _previousStatus = currentStatus;
    }
  }

  bool _shouldShowBanner(ConnectivityStatus status) {
    if (_bannerDismissed) return false;

    return status == ConnectivityStatus.offline ||
        status == ConnectivityStatus.checking ||
        (_showReconnectedMessage && status == ConnectivityStatus.online);
  }

  Map<String, dynamic> _getBannerData(ConnectivityStatus status) {
    if (_showReconnectedMessage && status == ConnectivityStatus.online) {
      return {
        'color': const Color(0xFF4CAF50), // Green
        'title': 'Connection restored',
        'subtitle': 'All features are now available',
      };
    }

    switch (status) {
      case ConnectivityStatus.offline:
        return {
          'color': const Color(0xFFE53935), // Red
          'title': 'No internet connection',
          'subtitle': 'Some features may be limited',
        };
      case ConnectivityStatus.checking:
        return {
          'color': const Color(0xFFFF9800), // Orange
          'title': 'Checking connection...',
          'subtitle': 'Please wait while we verify connectivity',
        };
      case ConnectivityStatus.online:
        return {
          'color': const Color(0xFF4CAF50), // Green
          'title': 'Connected',
          'subtitle': null,
        };
    }
  }

  IconData _getBannerIconData(ConnectivityStatus status) {
    if (_showReconnectedMessage && status == ConnectivityStatus.online) {
      return Icons.check_circle;
    }

    switch (status) {
      case ConnectivityStatus.offline:
        return Icons.wifi_off;
      case ConnectivityStatus.checking:
        return Icons.wifi_find;
      case ConnectivityStatus.online:
        return Icons.wifi;
    }
  }

  void _handleRetry() async {
    final connectivity = ref.read(connectivityServiceProvider);

    // Show checking state briefly
    await connectivity.checkConnectivity();

    // Provide user feedback
    if (mounted) {
      final newStatus = connectivity.status;
      if (newStatus == ConnectivityStatus.online) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 12),
                Text('Connection restored successfully'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    }
  }

  void _dismissBanner() {
    setState(() {
      _bannerDismissed = true;
    });
    _bannerAnimationController.reverse();
  }

  void _startReconnectedMessageTimer() {
    Future.delayed(widget.dismissTimeout, () {
      if (mounted) {
        setState(() {
          _showReconnectedMessage = false;
        });
      }
    });
  }
}

// Enhanced version with more customization options
class AdvancedConnectivityWrapper extends ConsumerWidget {
  final Widget child;
  final bool showBanner;
  final Widget Function(ConnectivityStatus status, Widget child)? customBuilder;
  final Map<ConnectivityStatus, BannerConfig>? customBannerConfigs;

  const AdvancedConnectivityWrapper({
    super.key,
    required this.child,
    this.showBanner = true,
    this.customBuilder,
    this.customBannerConfigs,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityServiceProvider);

    if (customBuilder != null) {
      return customBuilder!(connectivity.status, child);
    }

    return ConnectivityWrapper(
      showBanner: showBanner,
      child: child,
    );
  }
}

// Configuration class for custom banners
class BannerConfig {
  final Color backgroundColor;
  final String title;
  final String? subtitle;
  final IconData icon;
  final List<Widget> actions;
  final Duration? autoDismissDuration;

  const BannerConfig({
    required this.backgroundColor,
    required this.title,
    this.subtitle,
    required this.icon,
    this.actions = const [],
    this.autoDismissDuration,
  });
}

// Overlay version for non-intrusive notifications
class ConnectivityOverlay extends ConsumerStatefulWidget {
  final Widget child;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry margin;
  final Duration showDuration;

  const ConnectivityOverlay({
    super.key,
    required this.child,
    this.alignment = Alignment.topCenter,
    this.margin = const EdgeInsets.all(16),
    this.showDuration = const Duration(seconds: 4),
  });

  @override
  ConsumerState<ConnectivityOverlay> createState() =>
      _ConnectivityOverlayState();
}

class _ConnectivityOverlayState extends ConsumerState<ConnectivityOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  ConnectivityStatus? _previousStatus;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectivity = ref.watch(connectivityServiceProvider);

    _handleStatusChange(connectivity.status);

    return Stack(
      children: [
        widget.child,
        if (_isVisible)
          Positioned.fill(
            child: Align(
              alignment: widget.alignment,
              child: Container(
                margin: widget.margin,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value * 100),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildOverlayCard(connectivity.status),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildOverlayCard(ConnectivityStatus status) {
    final cardData = _getOverlayCardData(status);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: cardData['color'] as Color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              cardData['icon'] as IconData,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              cardData['message'] as String,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getOverlayCardData(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return {
          'color': Colors.green,
          'icon': Icons.wifi,
          'message': 'Connection restored',
        };
      case ConnectivityStatus.offline:
        return {
          'color': Colors.red,
          'icon': Icons.wifi_off,
          'message': 'Connection lost',
        };
      case ConnectivityStatus.checking:
        return {
          'color': Colors.orange,
          'icon': Icons.wifi_find,
          'message': 'Checking connection...',
        };
    }
  }

  void _handleStatusChange(ConnectivityStatus currentStatus) {
    if (_previousStatus != currentStatus) {
      if (currentStatus == ConnectivityStatus.offline ||
          (_previousStatus == ConnectivityStatus.offline &&
              currentStatus == ConnectivityStatus.online)) {
        _showOverlay();
      }
      _previousStatus = currentStatus;
    }
  }

  void _showOverlay() {
    setState(() {
      _isVisible = true;
    });

    _animationController.forward();

    Future.delayed(widget.showDuration, () {
      if (mounted) {
        _animationController.reverse().then((_) {
          if (mounted) {
            setState(() {
              _isVisible = false;
            });
          }
        });
      }
    });
  }
}
