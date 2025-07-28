import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/sign_in_screen.dart';
import '../../features/common/screens/no_access_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../providers/global_providers.dart';

// Custom error screen for better UX
class RouteErrorScreen extends StatelessWidget {
  final String error;

  const RouteErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.orange.shade300,
              ),
              const SizedBox(height: 24),
              Text(
                'Page Not Found',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'The requested page could not be found.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Error: $error',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
                      fontFamily: 'monospace',
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.home),
                label: const Text('Go to Dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Loading screen for better UX during navigation
class NavigationLoadingScreen extends StatelessWidget {
  const NavigationLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 24),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (_) => notifyListeners(),
      onError: (error) {
        debugPrint('Auth stream error: $error');
        // Don't notify on error to prevent navigation loops
      },
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authServiceProvider);
  final permissionSvc = ref.watch(permissionServiceProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true, // Enable for development

    // Enhanced error handling
    errorBuilder: (context, state) => RouteErrorScreen(
      error: state.error?.toString() ?? 'Unknown routing error',
    ),

    // Auto-redirect on auth state changes
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges),

    // Enhanced redirect logic with better error handling
    redirect: (context, state) async {
      try {
        final loggedIn = auth.currentUser != null;
        final loginLoc = state.matchedLocation == '/sign-in';
        final noAccessLoc = state.matchedLocation == '/no-access';

        debugPrint(
            'Router redirect: loggedIn=$loggedIn, location=${state.matchedLocation}');

        // Allow access to no-access page without authentication checks
        if (noAccessLoc) return null;

        // Redirect to sign-in if not logged in (except if already on sign-in page)
        if (!loggedIn && !loginLoc) {
          debugPrint('Redirecting to sign-in: user not logged in');
          return '/sign-in';
        }

        // Redirect to dashboard if logged in and on sign-in page
        if (loggedIn && loginLoc) {
          debugPrint('Redirecting to dashboard: user already logged in');
          return '/';
        }

        // Permission checks for protected routes
        if (loggedIn && auth.currentUser != null) {
          final location = state.matchedLocation;

          // Dashboard permission check
          if (location == '/') {
            try {
              final hasPermission = await permissionSvc.hasPermission(
                auth.currentUser!.uid,
                'view_dashboard',
              );
              if (!hasPermission) {
                debugPrint(
                    'Redirecting to no-access: missing view_dashboard permission');
                return '/no-access';
              }
            } catch (e) {
              debugPrint('Permission check failed for dashboard: $e');
              // Allow access if permission check fails (fail open for better UX)
            }
          }

          // Equipment management routes
          else if (location.startsWith('/equipment')) {
            try {
              final hasPermission = await permissionSvc.hasPermission(
                auth.currentUser!.uid,
                'manage_equipment',
              );
              if (!hasPermission) {
                debugPrint(
                    'Redirecting to no-access: missing manage_equipment permission');
                return '/no-access';
              }
            } catch (e) {
              debugPrint('Permission check failed for equipment: $e');
            }
          }

          // Reports routes
          else if (location.startsWith('/reports')) {
            try {
              final hasPermission = await permissionSvc.hasPermission(
                auth.currentUser!.uid,
                'view_reports',
              );
              if (!hasPermission) {
                debugPrint(
                    'Redirecting to no-access: missing view_reports permission');
                return '/no-access';
              }
            } catch (e) {
              debugPrint('Permission check failed for reports: $e');
            }
          }

          // Admin routes
          else if (location.startsWith('/admin')) {
            try {
              final hasPermission = await permissionSvc.hasPermission(
                auth.currentUser!.uid,
                'admin_access',
              );
              if (!hasPermission) {
                debugPrint(
                    'Redirecting to no-access: missing admin_access permission');
                return '/no-access';
              }
            } catch (e) {
              debugPrint('Permission check failed for admin: $e');
              return '/no-access'; // Fail closed for admin routes
            }
          }

          // Dynamic record routes
          else if (location.startsWith('/record/')) {
            try {
              final hasPermission = await permissionSvc.hasPermission(
                auth.currentUser!.uid,
                'view_records',
              );
              if (!hasPermission) {
                debugPrint(
                    'Redirecting to no-access: missing view_records permission');
                return '/no-access';
              }
            } catch (e) {
              debugPrint('Permission check failed for records: $e');
            }
          }
        }

        return null; // No redirect needed
      } catch (e) {
        debugPrint('Router redirect error: $e');
        // On error, don't redirect to prevent loops
        return null;
      }
    },

    routes: [
      // Main Dashboard Route
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),

      // Authentication Routes
      GoRoute(
        path: '/sign-in',
        name: 'signIn',
        builder: (context, state) => const SignInScreen(),
      ),

      GoRoute(
        path: '/no-access',
        name: 'noAccess',
        builder: (context, state) => const NoAccessScreen(),
      ),

      // Equipment Management Routes
      GoRoute(
        path: '/equipment',
        name: 'equipment',
        builder: (context, state) =>
            const NavigationLoadingScreen(), // Placeholder
        routes: [
          GoRoute(
            path: '/list',
            name: 'equipmentList',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
          GoRoute(
            path: '/add',
            name: 'equipmentAdd',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
          GoRoute(
            path: '/:id',
            name: 'equipmentDetail',
            builder: (context, state) {
              final equipmentId = state.pathParameters['id']!;
              return const NavigationLoadingScreen(); // Placeholder
            },
            routes: [
              GoRoute(
                path: '/edit',
                name: 'equipmentEdit',
                builder: (context, state) {
                  final equipmentId = state.pathParameters['id']!;
                  return const NavigationLoadingScreen(); // Placeholder
                },
              ),
            ],
          ),
        ],
      ),

      // Substation Management Routes
      GoRoute(
        path: '/substations',
        name: 'substations',
        builder: (context, state) =>
            const NavigationLoadingScreen(), // Placeholder
        routes: [
          GoRoute(
            path: '/list',
            name: 'substationList',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
          GoRoute(
            path: '/:id',
            name: 'substationDetail',
            builder: (context, state) {
              final substationId = state.pathParameters['id']!;
              return const NavigationLoadingScreen(); // Placeholder
            },
          ),
        ],
      ),

      // Maintenance Routes
      GoRoute(
        path: '/maintenance',
        name: 'maintenance',
        builder: (context, state) =>
            const NavigationLoadingScreen(), // Placeholder
        routes: [
          GoRoute(
            path: '/schedule',
            name: 'maintenanceSchedule',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
          GoRoute(
            path: '/records',
            name: 'maintenanceRecords',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
        ],
      ),

      // Reports Routes
      GoRoute(
        path: '/reports',
        name: 'reports',
        builder: (context, state) =>
            const NavigationLoadingScreen(), // Placeholder
        routes: [
          GoRoute(
            path: '/equipment',
            name: 'equipmentReports',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
          GoRoute(
            path: '/maintenance',
            name: 'maintenanceReports',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
          GoRoute(
            path: '/performance',
            name: 'performanceReports',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
        ],
      ),

      // User Management Routes
      GoRoute(
        path: '/users',
        name: 'users',
        builder: (context, state) =>
            const NavigationLoadingScreen(), // Placeholder
        routes: [
          GoRoute(
            path: '/list',
            name: 'userList',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
          GoRoute(
            path: '/roles',
            name: 'roleManagement',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
        ],
      ),

      // Admin Routes
      GoRoute(
        path: '/admin',
        name: 'admin',
        builder: (context, state) =>
            const NavigationLoadingScreen(), // Placeholder
        routes: [
          GoRoute(
            path: '/settings',
            name: 'adminSettings',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
          GoRoute(
            path: '/organizations',
            name: 'organizationManagement',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
          GoRoute(
            path: '/models',
            name: 'dynamicModelManagement',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
        ],
      ),

      // Profile & Settings Routes
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) =>
            const NavigationLoadingScreen(), // Placeholder
        routes: [
          GoRoute(
            path: '/edit',
            name: 'profileEdit',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
          GoRoute(
            path: '/preferences',
            name: 'preferences',
            builder: (context, state) =>
                const NavigationLoadingScreen(), // Placeholder
          ),
        ],
      ),

      // Generic Dynamic Record Routes (from your original code)
      GoRoute(
        path: '/record/:model',
        name: 'dynamicRecord',
        builder: (context, state) {
          final modelName = state.pathParameters['model']!;
          return const NavigationLoadingScreen(); // Placeholder for DynamicRecordScreen
        },
        routes: [
          GoRoute(
            path: '/:id',
            name: 'dynamicRecordDetail',
            builder: (context, state) {
              final modelName = state.pathParameters['model']!;
              final recordId = state.pathParameters['id']!;
              return const NavigationLoadingScreen(); // Placeholder
            },
            routes: [
              GoRoute(
                path: '/edit',
                name: 'dynamicRecordEdit',
                builder: (context, state) {
                  final modelName = state.pathParameters['model']!;
                  final recordId = state.pathParameters['id']!;
                  return const NavigationLoadingScreen(); // Placeholder
                },
              ),
            ],
          ),
        ],
      ),

      // Search Route
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) {
          final query = state.uri.queryParameters['q'] ?? '';
          return const NavigationLoadingScreen(); // Placeholder
        },
      ),

      // Notifications Route
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) =>
            const NavigationLoadingScreen(), // Placeholder
      ),
    ],
  );
});

// Helper extensions for better navigation
extension AppRouterExtension on GoRouter {
  void goToEquipment(String equipmentId) {
    go('/equipment/$equipmentId');
  }

  void goToSubstation(String substationId) {
    go('/substations/$substationId');
  }

  void goToRecord(String modelName, [String? recordId]) {
    if (recordId != null) {
      go('/record/$modelName/$recordId');
    } else {
      go('/record/$modelName');
    }
  }

  void goToReports(String reportType) {
    go('/reports/$reportType');
  }
}

// Router helper for accessing from widgets
extension BuildContextRouter on BuildContext {
  void goToEquipment(String equipmentId) {
    go('/equipment/$equipmentId');
  }

  void goToSubstation(String substationId) {
    go('/substations/$substationId');
  }

  void goToRecord(String modelName, [String? recordId]) {
    if (recordId != null) {
      go('/record/$modelName/$recordId');
    } else {
      go('/record/$modelName');
    }
  }
}
