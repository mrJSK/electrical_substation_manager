import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_footer.dart';

class AdminLayout extends ConsumerStatefulWidget {
  final Widget child;
  final String title;

  const AdminLayout({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  ConsumerState<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends ConsumerState<AdminLayout>
    with TickerProviderStateMixin {
  bool _sidebarExpanded = true;
  late AnimationController _sidebarController;
  late Animation<double> _sidebarAnimation;

  @override
  void initState() {
    super.initState();
    _sidebarController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _sidebarAnimation = Tween<double>(
      begin: 250.0,
      end: 80.0,
    ).animate(CurvedAnimation(
      parent: _sidebarController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth < 1024;
    final isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          // Sidebar
          if (!isMobile)
            AnimatedBuilder(
              animation: _sidebarAnimation,
              builder: (context, child) {
                return Container(
                  width: _sidebarExpanded ? 250.0 : 80.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF1E3A8A), // Deep blue
                        const Color(0xFF3B82F6), // Bright blue
                        const Color(0xFF06B6D4), // Cyan
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(2, 0),
                      ),
                    ],
                  ),
                  child: AdminSidebar(
                    expanded: _sidebarExpanded,
                    onToggle: () {
                      setState(() {
                        _sidebarExpanded = !_sidebarExpanded;
                      });
                      if (_sidebarExpanded) {
                        _sidebarController.reverse();
                      } else {
                        _sidebarController.forward();
                      }
                    },
                  ),
                );
              },
            ),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Header
                AdminHeader(
                  title: widget.title,
                  showMenuButton: isMobile,
                  onMenuPressed: () => _showMobileSidebar(context),
                ),

                // Content
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
                    child: widget.child,
                  ),
                ),

                // Footer
                const AdminFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showMobileSidebar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E3A8A),
              Color(0xFF3B82F6),
              Color(0xFF06B6D4),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: const AdminSidebar(expanded: true),
      ),
    );
  }

  @override
  void dispose() {
    _sidebarController.dispose();
    super.dispose();
  }
}
