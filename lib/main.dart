import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/core/utils/constants/assets/svg.dart';
import 'package:tob/features/add_property/bloc/add_property_bloc.dart';
import 'package:tob/features/add_property/repositories/property_repository.dart';
import 'package:tob/features/all_properties/bloc/all_properties_bloc.dart';
import 'package:tob/features/all_properties/repositories/all_properties_repository.dart';
import 'package:tob/features/auth/bloc/forgot_password_bloc.dart';
import 'package:tob/features/handyman/bloc/handyman_bloc.dart';
import 'package:tob/features/handyman/repositories/handyman_repository.dart';
import 'package:tob/features/artisan_profile/bloc/artisan_profile_bloc.dart';
import 'package:tob/features/home/repository/home_repository.dart';
import 'package:tob/features/referral/bloc/referral_bloc.dart';
import 'package:tob/features/referral/repository/referral_repository.dart';
import 'package:tob/features/tenant_profile/bloc/_tenant_profile_bloc.dart';
import 'package:tob/features/tenants/bloc/tenant_bloc.dart';
import 'package:tob/features/tenants/repositories/tenant_repository.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart' hide ThemeMode;
import 'core/network/api_service.dart';
import 'core/services/media_upload_service.dart';
import 'core/storage/secure_storage_service.dart';
import 'features/auth/repositories/auth_repository.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/bloc/login_bloc.dart';
import 'features/auth/bloc/register_bloc.dart';
import 'features/onboarding/cubit/onboarding_cubit.dart';
import 'features/dashboard/bloc/dashboard_bloc.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/expenses/bloc/expenses_bloc.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SvgAssets.preCacheSVGs();
  AuthHandler.onUnauthorized = () {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/login',
      (route) => false,
    );
  };
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
        RepositoryProvider(create: (context) => MediaUploadService(context.read<ApiService>())),
        RepositoryProvider(
          create: (context) => AuthRepository(
            apiService: context.read<ApiService>(),
            storageService: context.read<SecureStorageService>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => TenantRepository(
            context.read<ApiService>(),
            context.read<MediaUploadService>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => HomeRepository(
            apiService: context.read<ApiService>(),
          ),
        ),
        RepositoryProvider(create: (context) => ReferralRepository(apiService: context.read<ApiService>())),
        RepositoryProvider(
          create: (context) => HandymanRepository(
            apiService: context.read<ApiService>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => PropertyRepository(
            context.read<ApiService>(),
            context.read<MediaUploadService>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => AllPropertiesRepository(context.read<ApiService>()),
        ),
        RepositoryProvider(
          create: (context) => TenantRepository(
            context.read<ApiService>(),
            context.read<MediaUploadService>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(authRepository: context.read<AuthRepository>())),
          BlocProvider(create: (context) => LoginBloc(
            authRepository: context.read<AuthRepository>(),
            authBloc: context.read<AuthBloc>(),
          )),
          BlocProvider(create: (context) => RegisterBloc(authRepository: context.read<AuthRepository>())),
          BlocProvider(create: (context) => ForgotPasswordBloc(authRepository: context.read<AuthRepository>())),
          BlocProvider(create: (context) => OnboardingCubit()),
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => DashboardBloc()),
          BlocProvider(create: (context) => HomeBloc(homeRepository: context.read<HomeRepository>())),
          BlocProvider(create: (context) => AddPropertyBloc(propertyRepository: context.read<PropertyRepository>())),
          BlocProvider(create: (context) => TenantBloc(context.read<TenantRepository>())),
          BlocProvider(create: (context) => TenantProfileBloc(context.read<TenantRepository>())),
          BlocProvider(create: (context) => ExpensesBloc()),
          BlocProvider(create: (context) => AllPropertyBloc(repository: context.read<AllPropertiesRepository>(),)),
          BlocProvider(create: (context) => HandymanBloc(handymanRepository: context.read<HandymanRepository>())),
          BlocProvider(create: (context) => ArtisanProfileBloc(
            handymanRepository: context.read<HandymanRepository>(),
            authRepository: context.read<AuthRepository>(),
          )),
          BlocProvider(create: (context) => ReferralBloc(referralRepository: context.read<ReferralRepository>())),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              title: 'TOB',
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
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

