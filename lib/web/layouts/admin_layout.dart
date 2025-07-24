import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_footer.dart';

// 🔥 IMPROVED: Enhanced providers with better state management
final sidebarExpandedProvider = StateProvider<bool>((ref) => true);
final layoutModeProvider =
    StateProvider<LayoutMode>((ref) => LayoutMode.desktop);

// 🔥 NEW: Layout configuration provider
final layoutConfigProvider = Provider<LayoutConfig>((ref) {
  final mode = ref.watch(layoutModeProvider);
  return LayoutConfig.fromMode(mode);
});

enum LayoutMode { desktop, tablet, mobile }

// 🔥 NEW: Layout configuration class
class LayoutConfig {
  final double sidebarExpandedWidth;
  final double sidebarCollapsedWidth;
  final double contentPadding;
  final bool showSidebarByDefault;
  final bool allowSidebarToggle;
  final Duration animationDuration;

  const LayoutConfig({
    required this.sidebarExpandedWidth,
    required this.sidebarCollapsedWidth,
    required this.contentPadding,
    required this.showSidebarByDefault,
    required this.allowSidebarToggle,
    required this.animationDuration,
  });

  factory LayoutConfig.fromMode(LayoutMode mode) {
    switch (mode) {
      case LayoutMode.desktop:
        return const LayoutConfig(
          sidebarExpandedWidth: 280.0,
          sidebarCollapsedWidth: 80.0,
          contentPadding: 24.0,
          showSidebarByDefault: true,
          allowSidebarToggle: true,
          animationDuration: Duration(milliseconds: 300),
        );
      case LayoutMode.tablet:
        return const LayoutConfig(
          sidebarExpandedWidth: 260.0,
          sidebarCollapsedWidth: 70.0,
          contentPadding: 20.0,
          showSidebarByDefault: false,
          allowSidebarToggle: true,
          animationDuration: Duration(milliseconds: 250),
        );
      case LayoutMode.mobile:
        return const LayoutConfig(
          sidebarExpandedWidth: 280.0,
          sidebarCollapsedWidth: 0.0,
          contentPadding: 16.0,
          showSidebarByDefault: false,
          allowSidebarToggle: false,
          animationDuration: Duration(milliseconds: 200),
        );
    }
  }
}

class AdminLayout extends ConsumerStatefulWidget {
  final Widget child;
  final String title;
  final bool allowSidebarToggle;
  final EdgeInsets? contentPadding;
  final VoidCallback? onLayoutModeChanged; // 🔥 NEW: Layout change callback

  const AdminLayout({
    super.key,
    required this.child,
    required this.title,
    this.allowSidebarToggle = true,
    this.contentPadding,
    this.onLayoutModeChanged,
  });

  @override
  ConsumerState<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends ConsumerState<AdminLayout>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  // 🔥 IMPROVED: Simplified animation controllers
  late AnimationController _primaryController;
  late AnimationController _overlayController;

  late Animation<double> _sidebarAnimation;
  late Animation<double> _overlayAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _contentFadeAnimation;

  bool _isOverlayVisible = false;
  LayoutMode _currentLayoutMode = LayoutMode.desktop;

  // 🔥 IMPROVED: Responsive breakpoints
  static const _breakpoints = LayoutBreakpoints();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeAnimations();

    // 🔥 NEW: Initialize layout mode immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateLayoutMode();
    });
  }

  void _initializeAnimations() {
    // 🔥 IMPROVED: Single primary controller for sidebar animations
    _primaryController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _sidebarAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _primaryController,
      curve: Curves.easeInOutCubic,
    ));

    _contentFadeAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _primaryController,
      curve: Curves.easeOut,
    ));

    // Overlay controller for mobile sidebar
    _overlayController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _overlayAnimation = Tween<double>(begin: 0.0, end: 0.6).animate(
      CurvedAnimation(parent: _overlayController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _overlayController,
      curve: Curves.easeOutCubic,
    ));

    _primaryController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateLayoutMode();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // 🔥 IMPROVED: Debounced layout updates
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _updateLayoutMode();
    });
  }

  void _updateLayoutMode() {
    final screenWidth = MediaQuery.of(context).size.width;
    final newLayoutMode = _getLayoutMode(screenWidth);

    if (newLayoutMode != _currentLayoutMode) {
      setState(() {
        _currentLayoutMode = newLayoutMode;
      });

      ref.read(layoutModeProvider.notifier).state = newLayoutMode;

      // 🔥 NEW: Notify parent of layout changes
      widget.onLayoutModeChanged?.call();

      // 🔥 IMPROVED: Auto-adjust sidebar based on layout mode
      _handleLayoutModeChange(newLayoutMode);
    }
  }

  LayoutMode _getLayoutMode(double width) {
    if (width < LayoutBreakpoints.mobile) return LayoutMode.mobile;
    if (width < LayoutBreakpoints.tablet) return LayoutMode.tablet;
    return LayoutMode.desktop;
  }

  // 🔥 NEW: Handle layout mode changes
  void _handleLayoutModeChange(LayoutMode mode) {
    final config = LayoutConfig.fromMode(mode);

    switch (mode) {
      case LayoutMode.desktop:
        _setSidebarExpanded(config.showSidebarByDefault);
        _hideMobileSidebar(); // Close mobile overlay if open
        break;
      case LayoutMode.tablet:
        _setSidebarExpanded(config.showSidebarByDefault);
        _hideMobileSidebar();
        break;
      case LayoutMode.mobile:
        _setSidebarExpanded(false);
        _hideMobileSidebar();
        break;
    }
  }

  void _setSidebarExpanded(bool expanded) {
    if (!widget.allowSidebarToggle &&
        _currentLayoutMode == LayoutMode.desktop) {
      return;
    }

    ref.read(sidebarExpandedProvider.notifier).state = expanded;

    if (expanded) {
      _primaryController.forward();
    } else {
      _primaryController.reverse();
    }
  }

  void _toggleSidebar() {
    final isExpanded = ref.read(sidebarExpandedProvider);
    _setSidebarExpanded(!isExpanded);
  }

  void _showMobileSidebar() {
    if (_currentLayoutMode == LayoutMode.mobile) {
      setState(() {
        _isOverlayVisible = true;
      });
      _overlayController.forward();
    }
  }

  void _hideMobileSidebar() {
    if (_isOverlayVisible) {
      _overlayController.reverse().then((_) {
        if (mounted) {
          setState(() {
            _isOverlayVisible = false;
          });
        }
      });
    }
  }

  // 🔥 IMPROVED: Desktop layout with better animations
  Widget _buildDesktopLayout() {
    final isExpanded = ref.watch(sidebarExpandedProvider);
    final config = ref.watch(layoutConfigProvider);

    return AnimatedBuilder(
      animation: _contentFadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _contentFadeAnimation.value,
          child: Row(
            children: [
              // 🔥 IMPROVED: Animated sidebar with better performance
              AnimatedContainer(
                duration: config.animationDuration,
                curve: Curves.easeInOutCubic,
                width: isExpanded
                    ? config.sidebarExpandedWidth
                    : config.sidebarCollapsedWidth,
                child: Container(
                  decoration: _buildSidebarDecoration(),
                  child: AdminSidebar(
                    expanded: isExpanded,
                    onToggle: widget.allowSidebarToggle ? _toggleSidebar : null,
                  ),
                ),
              ),
              // Main Content
              Expanded(
                child: _buildMainContent(),
              ),
            ],
          ),
        );
      },
    );
  }

  // 🔥 IMPROVED: Mobile layout with better overlay handling
  Widget _buildMobileLayout() {
    return Stack(
      children: [
        // Main content (full width on mobile)
        _buildMobileMainContent(),

        // Mobile sidebar overlay
        if (_isOverlayVisible) ...[
          // 🔥 IMPROVED: Backdrop with better animation
          AnimatedBuilder(
            animation: _overlayAnimation,
            builder: (context, child) {
              return GestureDetector(
                onTap: _hideMobileSidebar,
                child: Container(
                  color: Colors.black.withOpacity(_overlayAnimation.value),
                ),
              );
            },
          ),

          // 🔥 IMPROVED: Sliding sidebar with better animation
          SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Material(
                elevation: 16,
                child: Container(
                  width: ref.watch(layoutConfigProvider).sidebarExpandedWidth,
                  height: double.infinity,
                  decoration: _buildSidebarDecoration(),
                  child: AdminSidebar(
                    expanded: true,
                    onToggle: _hideMobileSidebar,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMobileMainContent() {
    final config = ref.watch(layoutConfigProvider);

    return Column(
      children: [
        AdminHeader(
          title: widget.title,
          showMenuButton: true,
          onMenuPressed: _showMobileSidebar,
        ),
        Expanded(
          child: Container(
            padding:
                widget.contentPadding ?? EdgeInsets.all(config.contentPadding),
            child: widget.child,
          ),
        ),
        const AdminFooter(),
      ],
    );
  }

  Widget _buildMainContent() {
    final config = ref.watch(layoutConfigProvider);

    return Column(
      children: [
        // Header
        AdminHeader(
          title: widget.title,
          showMenuButton: false,
          onMenuPressed: null,
        ),

        // 🔥 IMPROVED: Content with better scroll physics
        Expanded(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: widget.contentPadding ??
                      EdgeInsets.all(config.contentPadding),
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),

        // Footer
        const AdminFooter(),
      ],
    );
  }

  // 🔥 NEW: Reusable sidebar decoration
  BoxDecoration _buildSidebarDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF1E3A8A),
          Color(0xFF1E40AF),
          Color(0xFF1D4ED8),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 20,
          offset: const Offset(2, 0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 NEW: Error boundary for layout failures
    return LayoutBuilder(
      builder: (context, constraints) {
        try {
          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            body: _currentLayoutMode == LayoutMode.mobile
                ? _buildMobileLayout()
                : _buildDesktopLayout(),
          );
        } catch (error, stackTrace) {
          // 🔥 NEW: Layout error handling
          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            body: _buildErrorLayout(error, stackTrace),
          );
        }
      },
    );
  }

  // 🔥 NEW: Error layout for layout failures
  Widget _buildErrorLayout(Object error, StackTrace stackTrace) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red.shade600,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Layout Error',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'An error occurred while rendering the layout.',
              style: TextStyle(
                color: Colors.red.shade600,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Force rebuild
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _primaryController.dispose();
    _overlayController.dispose();
    super.dispose();
  }
}

// 🔥 IMPROVED: Enhanced responsive utilities
extension ResponsiveLayout on BuildContext {
  bool get isMobile =>
      MediaQuery.of(this).size.width < LayoutBreakpoints.mobile;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= LayoutBreakpoints.mobile &&
      MediaQuery.of(this).size.width < LayoutBreakpoints.tablet;
  bool get isDesktop =>
      MediaQuery.of(this).size.width >= LayoutBreakpoints.tablet;

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  // 🔥 NEW: Content-aware responsive utilities
  EdgeInsets get responsivePadding {
    if (isMobile) return const EdgeInsets.all(16);
    if (isTablet) return const EdgeInsets.all(20);
    return const EdgeInsets.all(24);
  }

  double get responsiveFontSize => isMobile
      ? 14
      : isTablet
          ? 16
          : 18;

  int get responsiveColumns {
    if (isMobile) return 1;
    if (isTablet) return 2;
    return screenWidth > 1400 ? 4 : 3;
  }
}

// 🔥 IMPROVED: Enhanced breakpoints with more granular control
class LayoutBreakpoints {
  static const double mobile = 768.0;
  static const double tablet = 1024.0;
  static const double desktop = 1200.0;
  static const double largeDesktop = 1440.0;
  static const double ultraWide = 1920.0;

  const LayoutBreakpoints();
}

// 🔥 NEW: Layout performance optimization widget
class OptimizedLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, LayoutMode mode) builder;

  const OptimizedLayoutBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final layoutMode = ref.watch(layoutModeProvider);
        return builder(context, layoutMode);
      },
    );
  }
}

// 🔥 NEW: Responsive widget wrapper
class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveWidget({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop && desktop != null) return desktop!;
    if (context.isTablet && tablet != null) return tablet!;
    return mobile;
  }
}
