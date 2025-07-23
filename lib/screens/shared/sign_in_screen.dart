import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/auth_provider.dart';
import '../../providers/connectivity_provider.dart';

// Add these part directives for code generation
part 'sign_in_screen.freezed.dart';
part 'sign_in_screen.g.dart';

// Enhanced GoogleSignIn configuration
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'profile',
  ],
  // Add your web client ID if needed for web support
  // clientId: 'your-web-client-id.googleusercontent.com',
);

// Sign-in state management (move this BEFORE the notifier)
@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial() = SignInInitial;
  const factory SignInState.loading() = SignInLoading;
  const factory SignInState.success() = SignInSuccess;
  const factory SignInState.error(String message) = SignInError;
}

// Enhanced provider with better state management
@riverpod
class SignInNotifier extends _$SignInNotifier {
  @override
  SignInState build() {
    return const SignInState.initial();
  }

  Future<void> signInWithGoogle() async {
    try {
      state = const SignInState.loading();

      // Check internet connectivity first
      final isConnected = ref.read(connectivityNotifierProvider);
      if (!isConnected) {
        state = const SignInState.error(
            'No internet connection. Please check your network.');
        return;
      }

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        state = const SignInState.initial(); // User cancelled
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        state = const SignInState.success();
        // The auth wrapper will handle navigation automatically
      } else {
        state = const SignInState.error('Failed to sign in. Please try again.');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Sign-in failed. Please try again.';

      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage =
              'An account already exists with a different sign-in method.';
          break;
        case 'invalid-credential':
          errorMessage = 'Invalid credentials. Please try again.';
          break;
        case 'operation-not-allowed':
          errorMessage =
              'Google sign-in is not enabled. Please contact support.';
          break;
        case 'user-disabled':
          errorMessage =
              'Your account has been disabled. Please contact support.';
          break;
        case 'user-not-found':
          errorMessage = 'No account found. Please contact your administrator.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        default:
          errorMessage = 'Sign-in failed: ${e.message}';
      }

      state = SignInState.error(errorMessage);
    } catch (e) {
      state =
          SignInState.error('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      state = const SignInState.loading();

      // Sign out from Firebase and Google
      await Future.wait([
        FirebaseAuth.instance.signOut(),
        _googleSignIn.signOut(),
      ]);

      // Clear auth state
      ref.read(authStateNotifierProvider.notifier).refreshUserProfile();

      state = const SignInState.initial();
    } catch (e) {
      state = SignInState.error('Sign-out failed: ${e.toString()}');
    }
  }

  void clearError() {
    // Use the state directly instead of checking type
    state.when(
      initial: () {},
      loading: () {},
      success: () {},
      error: (_) => state = const SignInState.initial(),
    );
  }
}

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInNotifierProvider);
    final isConnected = ref.watch(connectivityNotifierProvider);

    // Listen to sign-in state changes for user feedback
    ref.listen<SignInState>(signInNotifierProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        success: () {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 12),
                    Text('Successfully signed in!'),
                  ],
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        error: (message) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(child: Text(message)),
                  ],
                ),
                backgroundColor: Colors.red.shade600,
                duration: const Duration(seconds: 4),
                behavior: SnackBarBehavior.floating,
                action: SnackBarAction(
                  label: 'Dismiss',
                  textColor: Colors.white,
                  onPressed: () {
                    ref.read(signInNotifierProvider.notifier).clearError();
                  },
                ),
              ),
            );
          }
        },
      );
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade300,
              Colors.blue.shade600,
              Colors.blue.shade800,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 2),

                // App Logo with enhanced styling
                Hero(
                  tag: 'app_logo',
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/logo.png',
                        height: 140,
                        width: 140,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Icon(
                              Icons.electrical_services,
                              size: 70,
                              color: Colors.blue,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // App Title with animation
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 800),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      const Text(
                        'Substation Manager Pro',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Welcome Back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.95),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Sign in to manage your electrical substations and access your personalized dashboard',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.85),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 3),

                // Connection Status Indicator
                if (!isConnected)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.wifi_off,
                            color: Colors.red.shade300, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'No internet connection',
                            style: TextStyle(
                              color: Colors.red.shade300,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Enhanced Sign In Button
                signInState.when(
                  initial: () => _buildSignInButton(ref, isConnected),
                  loading: () => _buildLoadingButton(),
                  success: () => _buildSuccessButton(),
                  error: (message) => _buildSignInButton(ref, isConnected),
                ),

                const SizedBox(height: 24),

                // Terms and Privacy with better styling
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'By signing in, you agree to our Terms of Service and Privacy Policy.\n\nFor support, contact your system administrator.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                      height: 1.4,
                    ),
                  ),
                ),

                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(WidgetRef ref, bool isConnected) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        icon: Image.asset(
          'assets/google_logo.webp',
          height: 24.0,
          width: 24.0,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.login, size: 24, color: Colors.blue);
          },
        ),
        label: const Text(
          'Sign in with Google',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: isConnected
            ? () => ref.read(signInNotifierProvider.notifier).signInWithGoogle()
            : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.blue.shade800,
          backgroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade600,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildLoadingButton() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 3,
              ),
            ),
            SizedBox(width: 16),
            Text(
              'Signing in...',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessButton() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 24),
            SizedBox(width: 16),
            Text(
              'Successfully signed in!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
