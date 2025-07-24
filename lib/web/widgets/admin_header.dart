import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminHeader extends ConsumerStatefulWidget {
  final String title;
  final bool showMenuButton;
  final VoidCallback? onMenuPressed;

  const AdminHeader({
    super.key,
    required this.title,
    this.showMenuButton = false,
    this.onMenuPressed,
  });

  @override
  ConsumerState<AdminHeader> createState() => _AdminHeaderState();
}

class _AdminHeaderState extends ConsumerState<AdminHeader>
    with TickerProviderStateMixin {
  late AnimationController _notificationController;
  late Animation<double> _notificationAnimation;

  @override
  void initState() {
    super.initState();
    _notificationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _notificationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _notificationController,
        curve: Curves.elasticOut,
      ),
    );
    _notificationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            // Menu Button (Mobile)
            if (widget.showMenuButton)
              IconButton(
                onPressed: widget.onMenuPressed,
                icon: const Icon(Icons.menu_rounded),
                iconSize: 28,
              ),

            // Title with Gradient
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                    ).createShader(bounds),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'Electrical Substation Management System',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search organizations, users...',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),

            const SizedBox(width: 24),

            // Action Buttons
            Row(
              children: [
                // Notifications with Animation
                AnimatedBuilder(
                  animation: _notificationAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (_notificationAnimation.value * 0.1),
                      child: Stack(
                        children: [
                          IconButton(
                            onPressed: () => _showNotifications(context),
                            icon: const Icon(Icons.notifications_rounded),
                            iconSize: 28,
                            color: Colors.grey[700],
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Text(
                                  '5',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(width: 16),

                // Settings
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings_rounded),
                  iconSize: 28,
                  color: Colors.grey[700],
                ),

                const SizedBox(width: 16),

                // User Profile
                GestureDetector(
                  onTap: () => _showUserMenu(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3B82F6).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: Color(0xFF1D4ED8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Admin',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.notifications_rounded,
                      color: Color(0xFF3B82F6)),
                  const SizedBox(width: 12),
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Mark all as read'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Sample notifications
              _buildNotificationItem(
                'New Organization Registration',
                'PowerGrid Corp has submitted registration',
                '2 minutes ago',
                Colors.green,
              ),
              _buildNotificationItem(
                'User Approval Pending',
                '5 users waiting for approval',
                '10 minutes ago',
                Colors.orange,
              ),
              _buildNotificationItem(
                'System Alert',
                'High server load detected',
                '1 hour ago',
                Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
      String title, String subtitle, String time, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  void _showUserMenu(BuildContext context) {
    // Implement user menu dropdown
  }

  @override
  void dispose() {
    _notificationController.dispose();
    super.dispose();
  }
}
