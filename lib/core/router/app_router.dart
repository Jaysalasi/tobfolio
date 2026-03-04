import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/features/auth/screens/forgot_password.dart';
import 'package:tob/features/auth/screens/create_new_password.dart';
import 'package:tob/features/home/bloc/home_bloc.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/onboarding/cubit/onboarding_cubit.dart';
import '../../features/dashboard/bloc/dashboard_bloc.dart';
import '../../core/theme/theme_cubit.dart';
import '../../core/network/api_service.dart';
import '../../core/storage/secure_storage_service.dart';
import '../../features/auth/repositories/auth_repository.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String createNewPassword = '/create-new-password';

  static const String dashboard = '/dashboard';
  static const String home = '/home';
  static const String search = '/search';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => ApiService(),
          ),
          RepositoryProvider(
            create: (context) => SecureStorageService(),
          ),
          RepositoryProvider(
            create: (context) => AuthRepository(
              apiService: context.read<ApiService>(),
              storageService: context.read<SecureStorageService>(),
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthBloc(authRepository: context.read<AuthRepository>())),
            BlocProvider(create: (context) => OnboardingCubit()),
            BlocProvider(create: (context) => ThemeCubit()),
            BlocProvider(create: (context) => DashboardBloc()),
          ],
          child: const SplashScreen(),
        ),
      ),
      onboarding: (context) => BlocProvider(
        create: (context) => OnboardingCubit(),
        child: const OnboardingScreen(),
      ),
      auth: (context) => BlocProvider(
        create: (context) => AuthBloc(authRepository: context.read<AuthRepository>()),
        child: const LoginScreen(),
      ),
      login: (context) => BlocProvider(
        create: (context) => AuthBloc(authRepository: context.read<AuthRepository>()),
        child: const LoginScreen(),
      ),
      register: (context) => BlocProvider(
        create: (context) => AuthBloc(authRepository: context.read<AuthRepository>()),
        child: const RegisterScreen(),
      ),
      forgotPassword: (context) => BlocProvider(
        create: (context) => AuthBloc(authRepository: context.read<AuthRepository>()),
        child: const ForgotPasswordScreen(),
      ),
      createNewPassword: (context) => BlocProvider(
        create: (context) => AuthBloc(authRepository: context.read<AuthRepository>()),
        child: const CreateNewPasswordScreen(),
      ),
      dashboard: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(authRepository: context.read<AuthRepository>())),
          BlocProvider(create: (context) => DashboardBloc()),
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => HomeBloc()),
        ],
        child: const DashboardScreen(),
      ),
    };
  }
}
