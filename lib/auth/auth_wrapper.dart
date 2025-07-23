// auth_wrapper.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_provider.dart';
import '../models/app_user.dart';
import '../screens/shared/sign_in_screen.dart';
import '../screens/shared/home_screen.dart';
import '../screens/shared/splash_screen.dart';
import '../screens/shared/error_screen.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider);

    return authState.when(
      loading: () => const SplashScreen(),
      authenticated: (user) => HomeScreen(user: user),
      unauthenticated: () => const SignInScreen(),
      error: (error, message) => ErrorScreen(
        error: error,
        message: message,
        onRetry: () =>
            ref.read(authStateNotifierProvider.notifier).refreshUserProfile(),
      ),
    );
  }
}
