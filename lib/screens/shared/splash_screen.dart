import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/auth_provider.dart';
import '../../models/app_user.dart';
import '../../providers/connectivity_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late AnimationController _rotationController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  bool _hasNavigated = false;
  String _loadingMessage = 'Initializing...';
  bool _showRetryButton = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startInitialDelay();
  }

  void _initializeAnimations() {
    // Fade animation for overall entrance
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Scale animation for logo entrance
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Pulse animation for loading indicator
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Rotation animation for electrical icon
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    // Start animations
    _fadeController.forward();
    _scaleController.forward();
    _pulseController.repeat(reverse: true);
    _rotationController.repeat();
  }

  void _startInitialDelay() {
    // Give a minimum splash time for better UX
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _loadingMessage = 'Checking authentication...';
        });
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  void _handleRetry() {
    if (_hasNavigated) return;

    setState(() {
      _showRetryButton = false;
      _loadingMessage = 'Retrying...';
    });

    // Refresh auth provider
    ref.invalidate(authStateNotifierProvider);
  }

  void _updateLoadingMessage(AuthState authState) {
    if (!mounted) return;

    authState.when(
      loading: () {
        setState(() {
          _loadingMessage = 'Checking authentication...';
          _showRetryButton = false;
        });
      },
      authenticated: (user) {
        setState(() {
          _loadingMessage = 'Welcome back, ${user.name}!';
          _showRetryButton = false;
        });
      },
      unauthenticated: () {
        setState(() {
          _loadingMessage = 'Redirecting to sign in...';
          _showRetryButton = false;
        });
      },
      error: (error, message) {
        setState(() {
          _loadingMessage = 'Connection error occurred';
          _showRetryButton = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check connectivity status
    final isConnected = ref.watch(connectivityNotifierProvider);

    // Watch auth state and handle navigation
    final authState = ref.watch(authStateNotifierProvider);

    // Update loading message based on auth state
    _updateLoadingMessage(authState);

    // Listen to auth state changes for navigation
    ref.listen<AuthState>(authStateNotifierProvider, (previous, next) {
      if (_hasNavigated) return;

      // Add minimum splash duration
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted || _hasNavigated) return;

        next.when(
          loading: () {
            // Still loading, don't navigate yet
          },
          authenticated: (user) {
            _hasNavigated = true;
            // Navigation handled by AuthWrapper
          },
          unauthenticated: () {
            _hasNavigated = true;
            // Navigation handled by AuthWrapper
          },
          error: (error, message) {
            // Don't navigate on error, show retry option
            if (mounted) {
              setState(() {
                _showRetryButton = true;
                _loadingMessage = 'Failed to connect. Please try again.';
              });
            }
          },
        );
      });
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade700,
              Colors.blue.shade900,
              Colors.indigo.shade900,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo with enhanced animations
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: RotationTransition(
                      turns: _rotationAnimation,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 25,
                              offset: const Offset(0, 15),
                            ),
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.2),
                              blurRadius: 40,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.electrical_services,
                            size: 70,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // App Title with typing effect
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      children: [
                        const Text(
                          'Substation Manager Pro',
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
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Professional Electrical Management System',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 0.8,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 80),

                  // Enhanced loading section
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: Column(
                      children: [
                        // Connection status indicator
                        if (!isConnected)
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.red.withOpacity(0.4),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.wifi_off,
                                  color: Colors.red.shade300,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'No Internet Connection',
                                  style: TextStyle(
                                    color: Colors.red.shade300,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Loading indicator or retry button
                        if (_showRetryButton)
                          Column(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.orange.shade300,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: _handleRetry,
                                icon: const Icon(Icons.refresh),
                                label: const Text('Retry'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blue.shade800,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: authState.when(
                              loading: () => CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white.withOpacity(0.9),
                                ),
                                strokeWidth: 4,
                              ),
                              authenticated: (user) => const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 50,
                              ),
                              unauthenticated: () => CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white.withOpacity(0.9),
                                ),
                                strokeWidth: 4,
                              ),
                              error: (error, message) => Icon(
                                Icons.error_outline,
                                color: Colors.orange.shade300,
                                size: 50,
                              ),
                            ),
                          ),

                        const SizedBox(height: 24),

                        // Loading message
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            _loadingMessage,
                            key: ValueKey(_loadingMessage),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // App version and copyright
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        Text(
                          'Version 1.0.0',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '© 2024 Electrical Management Solutions',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
