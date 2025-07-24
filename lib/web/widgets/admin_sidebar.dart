import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Provider for sidebar state management
final sidebarExpandedProvider = StateProvider<bool>((ref) => true);
final selectedRouteProvider = StateProvider<String>((ref) => '/admin');

class AdminSidebar extends ConsumerStatefulWidget {
  final bool expanded;
  final VoidCallback? onToggle;

  const AdminSidebar({
    super.key,
    required this.expanded,
    this.onToggle,
  });

  @override
  ConsumerState<AdminSidebar> createState() => _AdminSidebarState();
}

class _AdminSidebarState extends ConsumerState<AdminSidebar>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _expandController;
  late Animation<double> _logoAnimation;
  late Animation<double> _expandAnimation;

  String? selectedRoute;

  final List<SidebarItem> _menuItems = [
    SidebarItem(
      icon: Icons.dashboard_rounded,
      title: 'Dashboard',
      route: '/admin',
      gradient: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
      description: 'Overview & Statistics',
    ),
    SidebarItem(
      icon: Icons.business_rounded,
      title: 'Organizations',
      route: '/admin/organizations',
      gradient: [Color(0xFF10B981), Color(0xFF059669)],
      description: 'Manage Organizations',
    ),
    SidebarItem(
      icon: Icons.people_rounded,
      title: 'User Management',
      route: '/admin/users',
      gradient: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
      description: 'Users & Access Control',
    ),
    SidebarItem(
      icon: Icons.approval_rounded,
      title: 'Approvals',
      route: '/admin/approvals',
      gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
      badge: '12',
      description: 'Pending Approvals',
      isUrgent: true,
    ),
    SidebarItem(
      icon: Icons.electrical_services_rounded,
      title: 'Substations',
      route: '/admin/substations',
      gradient: [Color(0xFFEF4444), Color(0xFFDC2626)],
      description: 'Power Infrastructure',
    ),
    SidebarItem(
      icon: Icons.analytics_rounded,
      title: 'Analytics',
      route: '/admin/analytics',
      gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
      description: 'Reports & Insights',
    ),
    SidebarItem(
      icon: Icons.security_rounded,
      title: 'Roles & Permissions',
      route: '/admin/roles',
      gradient: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
      description: 'Security Management',
    ),
    SidebarItem(
      icon: Icons.settings_rounded,
      title: 'Settings',
      route: '/admin/settings',
      gradient: [Color(0xFF6B7280), Color(0xFF4B5563)],
      description: 'System Configuration',
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Logo animation
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    // Expand/collapse animation
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _expandController, curve: Curves.easeInOut),
    );

    _logoController.forward();
    if (widget.expanded) _expandController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ✅ Safe to access context here
    final currentRoute = GoRouterState.of(context).uri.toString();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(selectedRouteProvider.notifier).state = currentRoute;
        setState(() {
          selectedRoute = currentRoute;
        });
      }
    });
  }

  @override
  void didUpdateWidget(AdminSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expanded != oldWidget.expanded) {
      if (widget.expanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    }
  }

  void _onItemTapped(SidebarItem item) {
    setState(() {
      selectedRoute = item.route;
    });
    ref.read(selectedRouteProvider.notifier).state = item.route;
    context.go(item.route);

    // Haptic feedback for better UX
    // HapticFeedback.lightImpact();
  }

  Widget _buildMenuItem(SidebarItem item, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: Tooltip(
          message: widget.expanded ? '' : '${item.title}\n${item.description}',
          preferBelow: false,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _onItemTapped(item),
            onHover: (hovering) {
              // Add subtle hover effects
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.25),
                          Colors.white.withOpacity(0.15),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(
                        color: Colors.white.withOpacity(0.4),
                        width: 1.5,
                      )
                    : null,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  // Icon with gradient background
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: item.gradient),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: item.gradient[0].withOpacity(0.4),
                          blurRadius: isSelected ? 8 : 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      item.icon,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),

                  // Title and description (when expanded)
                  if (widget.expanded) ...[
                    const SizedBox(width: 14),
                    Expanded(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: _expandAnimation.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                            if (item.description != null)
                              Text(
                                item.description!,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 11,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    // Badge with animation
                    if (item.badge != null)
                      AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: _expandAnimation.value,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: item.isUrgent ? Colors.red : Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    (item.isUrgent ? Colors.red : Colors.blue)
                                        .withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            item.badge!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ] else if (item.badge != null) ...[
                    // Show badge as dot when collapsed
                    const SizedBox(width: 4),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: item.isUrgent ? Colors.red : Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ref.watch(selectedRouteProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.expanded ? 280 : 80,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A),
              Color(0xFF1E40AF),
              Color(0xFF1D4ED8),
            ],
          ),
        ),
        child: Column(
          children: [
            // Enhanced Header Section
            Container(
              height: 80,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Animated Logo
                  AnimatedBuilder(
                    animation: _logoAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoAnimation.value,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.electric_bolt_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      );
                    },
                  ),

                  if (widget.expanded) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: _expandAnimation.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ElectriAdmin',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              'Substation Manager Pro',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Toggle button
                  if (widget.onToggle != null)
                    IconButton(
                      onPressed: widget.onToggle,
                      icon: AnimatedRotation(
                        duration: const Duration(milliseconds: 300),
                        turns: widget.expanded ? 0 : 0.5,
                        child: Icon(
                          Icons.menu_open_rounded,
                          color: Colors.white.withOpacity(0.9),
                          size: 24,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Divider
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Menu Items with improved scrolling
            Expanded(
              child: Scrollbar(
                thumbVisibility: widget.expanded,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _menuItems.length,
                  itemBuilder: (context, index) {
                    final item = _menuItems[index];
                    final isSelected = currentRoute.startsWith(item.route);
                    return _buildMenuItem(item, isSelected);
                  },
                ),
              ),
            ),

            // Enhanced User Profile Section
            if (widget.expanded)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _expandAnimation.value,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.15),
                        Colors.white.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.grey[200]!],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: Color(0xFF1E3A8A),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Admin User',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'System Administrator',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert_rounded,
                          color: Colors.white.withOpacity(0.8),
                          size: 20,
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.person_outline, size: 18),
                                SizedBox(width: 12),
                                Text('Profile'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.settings_outlined, size: 18),
                                SizedBox(width: 12),
                                Text('Preferences'),
                              ],
                            ),
                          ),
                          PopupMenuDivider(),
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.logout_outlined,
                                    size: 18, color: Colors.red),
                                SizedBox(width: 12),
                                Text('Logout',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _expandController.dispose();
    super.dispose();
  }
}

// Enhanced SidebarItem class
class SidebarItem {
  final IconData icon;
  final String title;
  final String route;
  final List<Color> gradient;
  final String? badge;
  final String? description;
  final bool isUrgent;

  SidebarItem({
    required this.icon,
    required this.title,
    required this.route,
    required this.gradient,
    this.badge,
    this.description,
    this.isUrgent = false,
  });
}
