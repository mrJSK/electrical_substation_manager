// Replace the existing dashboard_screen.dart with this enhanced version
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/dashboard_provider.dart';
import '../../../core/providers/global_providers.dart';
import '../widgets/dynamic_dashboard.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh dashboard data
              ref.invalidate(userDashboardProvider);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async => await auth.signOut(),
          ),
        ],
      ),
      body: const DynamicDashboard(),
    );
  }
}
