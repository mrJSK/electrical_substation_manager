import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_footer.dart';

// Providers for layout state management
final sidebarExpandedProvider = StateProvider<bool>((ref) => true);
final layoutModeProvider =
    StateProvider<LayoutMode>((ref) => LayoutMode.desktop);

enum LayoutMode { desktop, tablet, mobile }

class AdminLayout extends ConsumerStatefulWidget {
  final Widget child;
  final String title;
  final bool allowSidebarToggle;
  final EdgeInsets? contentPadding;

  const AdminLayout({
    super.key,
    required this.child,
    required this.title,
    this.allowSidebarToggle = true,
    this.contentPadding,
  });

  @override
  ConsumerState<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends ConsumerState<AdminLayout>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _sidebarController;
  late AnimationController _overlayController;
  late AnimationController _contentController;

  late Animation<double> _sidebarAnimation;
  late Animation<double> _overlayAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isOverlayVisible = false;
  LayoutMode _currentLayoutMode = LayoutMode.desktop;

  // Breakpoints for responsive design
  static const double tabletBreakpoint = 1024.0;
  static const double mobileBreakpoint = 768.0;
  static const double sidebarExpandedWidth = 280.0;
  static const double sidebarCollapsedWidth = 80.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Sidebar width animation
    _sidebarController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _sidebarAnimation = Tween<double>(
      begin: sidebarExpandedWidth,
      end: sidebarCollapsedWidth,
    ).animate(CurvedAnimation(
      parent: _sidebarController,
      curve: Curves.easeInOutCubic,
    ));

    // Overlay animation for mobile sidebar
    _overlayController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _overlayAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _overlayController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _overlayController,
      curve: Curves.easeOutCubic,
    ));

    // Content animation
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _contentController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateLayoutMode();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
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

      // Auto-collapse sidebar on tablet mode
      if (newLayoutMode == LayoutMode.tablet) {
        _setSidebarExpanded(false);
      } else if (newLayoutMode == LayoutMode.desktop) {
        _setSidebarExpanded(true);
      }
    }
  }

  LayoutMode _getLayoutMode(double width) {
    if (width < mobileBreakpoint) return LayoutMode.mobile;
    if (width < tabletBreakpoint) return LayoutMode.tablet;
    return LayoutMode.desktop;
  }

  void _setSidebarExpanded(bool expanded) {
    if (!widget.allowSidebarToggle && _currentLayoutMode == LayoutMode.desktop)
      return;

    ref.read(sidebarExpandedProvider.notifier).state = expanded;
    if (expanded) {
      _sidebarController.reverse();
    } else {
      _sidebarController.forward();
    }
  }

  void _toggleSidebar() {
    final isExpanded = ref.read(sidebarExpandedProvider);
    _setSidebarExpanded(!isExpanded);
  }

  void _showMobileSidebar() {
    setState(() {
      _isOverlayVisible = true;
    });
    _overlayController.forward();
  }

  void _hideMobileSidebar() {
    _overlayController.reverse().then((_) {
      if (mounted) {
        setState(() {
          _isOverlayVisible = false;
        });
      }
    });
  }

  Widget _buildDesktopLayout() {
    final isExpanded = ref.watch(sidebarExpandedProvider);

    return Row(
      children: [
        // Animated Sidebar
        AnimatedBuilder(
          animation: _sidebarAnimation,
          builder: (context, child) {
            return Container(
              width: isExpanded ? sidebarExpandedWidth : sidebarCollapsedWidth,
              decoration: BoxDecoration(
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
              ),
              child: AdminSidebar(
                expanded: isExpanded,
                onToggle: widget.allowSidebarToggle ? _toggleSidebar : null,
              ),
            );
          },
        ),

        // Main Content
        Expanded(
          child: _buildMainContent(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Stack(
      children: [
        // Main content (full width on mobile)
        Column(
          children: [
            AdminHeader(
              title: widget.title,
              showMenuButton: true,
              onMenuPressed: _showMobileSidebar,
            ),
            Expanded(
              child: Container(
                padding: widget.contentPadding ?? const EdgeInsets.all(16.0),
                child: widget.child,
              ),
            ),
            const AdminFooter(),
          ],
        ),

        // Mobile sidebar overlay
        if (_isOverlayVisible) ...[
          // Backdrop
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

          // Sliding sidebar
          SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: sidebarExpandedWidth,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
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
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(4, 0),
                    ),
                  ],
                ),
                child: AdminSidebar(
                  expanded: true,
                  onToggle: _hideMobileSidebar,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMainContent() {
    return AnimatedBuilder(
      animation: _contentController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _contentController,
          child: Column(
            children: [
              // Header
              AdminHeader(
                title: widget.title,
                showMenuButton: false,
                onMenuPressed: null,
              ),

              // Content with scroll physics
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(
                        padding: widget.contentPadding ??
                            EdgeInsets.all(
                                _currentLayoutMode == LayoutMode.mobile
                                    ? 16.0
                                    : 24.0),
                        child: widget.child,
                      ),
                    ),
                  ],
                ),
              ),

              // Footer
              const AdminFooter(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: _currentLayoutMode == LayoutMode.mobile
          ? _buildMobileLayout()
          : _buildDesktopLayout(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sidebarController.dispose();
    _overlayController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

// Extension for responsive utilities
extension ResponsiveLayout on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 768;
  bool get isTablet =>
      MediaQuery.of(this).size.width < 1024 &&
      MediaQuery.of(this).size.width >= 768;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1024;

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}

// Utility class for responsive breakpoints
class LayoutBreakpoints {
  static const double mobile = 768.0;
  static const double tablet = 1024.0;
  static const double desktop = 1200.0;
  static const double largeDesktop = 1440.0;
}
