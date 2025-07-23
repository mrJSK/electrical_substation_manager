import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_user.dart';
import '../auth/auth_provider.dart';

class AppDrawer extends ConsumerWidget {
  final AppUser user;

  const AppDrawer({super.key, required this.user});

  List<DrawerItem> _getDrawerItemsForRole(UserRole role) {
    final baseItems = [
      DrawerItem(
        icon: Icons.dashboard,
        title: 'Dashboard',
        route: '/dashboard',
      ),
    ];

    switch (role) {
      case UserRole.admin:
        return [
          ...baseItems,
          DrawerItem(icon: Icons.people, title: 'Users', route: '/users'),
          DrawerItem(
              icon: Icons.business, title: 'Companies', route: '/companies'),
          DrawerItem(
              icon: Icons.analytics, title: 'Analytics', route: '/analytics'),
          DrawerItem(
              icon: Icons.settings, title: 'Settings', route: '/settings'),
        ];
      case UserRole.stateManager:
        return [
          ...baseItems,
          DrawerItem(
              icon: Icons.business, title: 'Companies', route: '/companies'),
          DrawerItem(
              icon: Icons.bar_chart, title: 'Reports', route: '/reports'),
        ];
      case UserRole.companyManager:
        return [
          ...baseItems,
          DrawerItem(
              icon: Icons.location_city, title: 'Zones', route: '/zones'),
          DrawerItem(
              icon: Icons.bar_chart, title: 'Reports', route: '/reports'),
        ];
      case UserRole.zoneManager:
        return [
          ...baseItems,
          DrawerItem(
              icon: Icons.radio_button_checked,
              title: 'Circles',
              route: '/circles'),
          DrawerItem(
              icon: Icons.bar_chart, title: 'Reports', route: '/reports'),
        ];
      case UserRole.circleManager:
        return [
          ...baseItems,
          DrawerItem(
              icon: Icons.category, title: 'Divisions', route: '/divisions'),
          DrawerItem(
              icon: Icons.bar_chart, title: 'Reports', route: '/reports'),
        ];
      case UserRole.divisionManager:
        return [
          ...baseItems,
          DrawerItem(
              icon: Icons.scatter_plot,
              title: 'Subdivisions',
              route: '/subdivisions'),
          DrawerItem(
              icon: Icons.bar_chart, title: 'Reports', route: '/reports'),
        ];
      case UserRole.subdivisionManager:
        return [
          ...baseItems,
          DrawerItem(
              icon: Icons.electrical_services,
              title: 'Substations',
              route: '/substations'),
          DrawerItem(
              icon: Icons.bar_chart, title: 'Reports', route: '/reports'),
        ];
      case UserRole.substationUser:
        return [
          ...baseItems,
          DrawerItem(
              icon: Icons.electrical_services,
              title: 'My Substation',
              route: '/my-substation'),
        ];
      case UserRole.unknown:
        return baseItems;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawerItems = _getDrawerItemsForRole(user.role);

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage:
                  user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
              child: user.photoUrl == null
                  ? Text(
                      user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U')
                  : null,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (context, index) {
                final item = drawerItems[index];
                return ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.title),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, item.route);
                  },
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () async {
              Navigator.pop(context);
              await ref.read(authStateNotifierProvider.notifier).signOut();
            },
          ),
        ],
      ),
    );
  }
}

class DrawerItem {
  final IconData icon;
  final String title;
  final String route;

  DrawerItem({
    required this.icon,
    required this.title,
    required this.route,
  });
}
