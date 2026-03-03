import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart' hide ThemeMode;
import 'core/network/api_service.dart';
import 'core/storage/secure_storage_service.dart';
import 'features/auth/repositories/auth_repository.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/onboarding/cubit/onboarding_cubit.dart';
import 'features/dashboard/bloc/dashboard_bloc.dart';
import 'features/home/bloc/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SvgAssets.preCacheSVGs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ApiService()),
        RepositoryProvider(create: (context) => SecureStorageService()),
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
          BlocProvider(create: (context) => HomeBloc()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              title: 'TOB',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: _getThemeMode(themeState.themeMode.name),
              initialRoute: AppRouter.splash,
              routes: AppRouter.getRoutes(),
            );
          },
        ),
      ),
    );
  }

  ThemeMode _getThemeMode(String modeName) {
    switch (modeName) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }
}

