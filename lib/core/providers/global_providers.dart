import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/permission_service.dart';
import '../services/connectivity_service.dart';
import '../services/auth_service.dart';
import '../services/dashboard_service.dart';

// Core service providers
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final permissionServiceProvider =
    Provider<PermissionService>((ref) => PermissionService());

final dashboardServiceProvider =
    Provider<DashboardService>((ref) => DashboardService());

final connectivityServiceProvider =
    Provider<ConnectivityService>((ref) => ConnectivityService());

// Auth state provider
final currentUserProvider = StreamProvider((ref) {
  final auth = ref.watch(authServiceProvider);
  return auth.authStateChanges;
});

// User profile provider
final userProfileProvider =
    FutureProvider.family<UserModel?, String>((ref, userId) async {
  final auth = ref.watch(authServiceProvider);
  return await auth.getUserProfile(userId);
});
