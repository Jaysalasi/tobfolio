import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/features/auth/bloc/auth_bloc.dart';
import 'package:tob/features/onboarding/cubit/onboarding_cubit.dart'; 
class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();

    // 🔥 Start auth check immediately
    context.read<AuthBloc>().add(AuthStarted());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleNavigation(BuildContext context, AuthState state) async {
    final onboardingCubit = context.read<OnboardingCubit>();
    final isFirstTime = await onboardingCubit.checkFirstTime();

    if (isFirstTime) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
      return;
    }

    if (state.status == AuthStatus.authenticated) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } else {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/auth');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // 🚀 Navigate ONLY when auth state is ready
        if (state.status == AuthStatus.authenticated ||
            state.status == AuthStatus.unauthenticated) {
          _handleNavigation(context, state);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 🔷 LOGO
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.home,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 🔤 APP NAME
                  const Text(
                    'Estate Manager',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 🔄 LOADING
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}