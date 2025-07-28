import 'dart:async'; // Add this import for StreamSubscription
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/sign_in_screen.dart';
import '../../features/common/screens/no_access_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/dynamic_form/screens/dynamic_record_screen.dart';
import '../providers/global_providers.dart'
    hide authServiceProvider; // Add this import

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
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
  final permissionSvc =
      ref.watch(permissionServiceProvider); // Now this will work!

  return GoRouter(
    initialLocation: '/',
    refreshListenable:
        GoRouterRefreshStream(auth.authStateChanges), // auto-redirect on auth
    redirect: (ctx, state) async {
      final loggedIn = auth.currentUser != null;
      final loginLoc = state.matchedLocation == '/sign-in';

      if (!loggedIn && !loginLoc) return '/sign-in';
      if (loggedIn && loginLoc) return '/';

      // Example: dashboard permission guard
      if (state.matchedLocation == '/' ||
          state.matchedLocation.startsWith('/record/')) {
        final ok = await permissionSvc.hasPermission(
          auth.currentUser!.uid,
          'view_dashboard',
        );
        if (!ok) return '/no-access';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (_, __) => const SignInScreen(),
      ),
      GoRoute(
        path: '/no-access',
        builder: (_, __) => const NoAccessScreen(),
      ),
      // Generic dynamic-record screen
      GoRoute(
        path: '/record/:model',
        name: 'record',
        builder: (_, state) =>
            DynamicRecordScreen(modelName: state.pathParameters['model']!),
      ),
    ],
  );
});
