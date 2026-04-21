import 'package:dio/dio.dart';
import 'package:tob/features/auth/bloc/forgot_password_state.dart';
import '../../../core/utils/logger.dart';
import '../models/user.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/register_request.dart';
import '../models/auth_response.dart';
import '../../../core/network/api_service.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../../core/network/network_exceptions.dart';

class AuthRepository {
  final ApiService _apiService;
  final SecureStorageService _storageService;

  AuthRepository({
    required ApiService apiService,
    required SecureStorageService storageService,
  })  : _apiService = apiService,
        _storageService = storageService;

  Future<LoginResponse> login(LoginRequest request) async {
  authLogger.d('Login attempt for email: ${request.email}');
  try {
    final response = await _apiService.post('/auth/login', data: request.toJson());
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      final loginResponse = LoginResponse.fromJson(response.data);
      // Save token and user data
      await _storageService.saveToken(loginResponse.token);
      await _storageService.saveUser(loginResponse.user.toJson());
      await saveTokenWithTime(loginResponse.token);
      
      // Set auth token for API service
      // _apiService.setAuthToken(loginResponse.token);
      
      authLogger.i('Login successful for user: ${loginResponse.user.name}');
      return loginResponse;
    } else {
      print("response : ${response}");
      final errorMessage = NetworkExceptions.getErrorMessage(response.data);
      authLogger.e('Login failed: $errorMessage');
      throw errorMessage;
    }
  } catch (e) {
    if (e is DioException) {
      final errorMessage = NetworkExceptions.handleDioError(e);
      authLogger.e('Login Dio error: $errorMessage');
      throw errorMessage;
    }
    final errorMessage = NetworkExceptions.getErrorMessage(e);
    authLogger.e('Login error: $errorMessage');
    throw errorMessage;
  }
}

  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest request) async {
  authLogger.d('Login attempt for email: ${request.email}');
  try {
    final response = await _apiService.post('/auth/forgot-password', data: request.toJson());
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      final resResponse = ForgotPasswordResponse.fromJson(response.data);

      authLogger.i('Forgot password successful for user: ');
      return resResponse;
    } else {
      final errorMessage = NetworkExceptions.getErrorMessage(response.data);
      authLogger.e('Login failed: $errorMessage');
      throw errorMessage;
    }
  } catch (e) {
    if (e is DioException) {
      final errorMessage = NetworkExceptions.handleDioError(e);
      authLogger.e('Login Dio error: $errorMessage');
      throw errorMessage;
    }
    final errorMessage = NetworkExceptions.getErrorMessage(e);
    authLogger.e('Login error: $errorMessage');
    throw errorMessage;
  }
}

  Future<AuthResponse> register(RegisterRequest request) async {
    authLogger.d('Registration attempt for email: ${request.email}');
    try {
      final response = await _apiService.post('/auth/register', data: request.toJson());
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final authResponse = AuthResponse.fromJson(response.data);
        
        // await _storageService.saveToken(authResponse.token);
        // await _storageService.saveRefreshToken(authResponse.refreshToken);
        // await _storageService.saveUser(authResponse.user.toJson());
        // _apiService.setAuthToken("authResponse.token");      
        // authLogger.i('Registration successful for user: ${authResponse.user.fname}');
        return authResponse;
      } else {
        final errorMessage = NetworkExceptions.getErrorMessage(response.data);
        authLogger.e('Registration failed: $errorMessage');
        throw errorMessage;
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = NetworkExceptions.handleDioError(e);
        authLogger.e('Registration Dio error: $errorMessage');
        throw errorMessage;
      }
      final errorMessage = NetworkExceptions.getErrorMessage(e);
      authLogger.e('Registration error: $errorMessage');
      throw errorMessage;
    }
  }

  Future<void> logout() async {
    authLogger.d('Logout attempt');
    try {
      await _apiService.post('/auth/logout');
      authLogger.i('Logout successful');
    } catch (e) {
      authLogger.w('Logout API call failed: $e');
      // Continue with logout even if API call fails
    } finally {
      await _storageService.clearAll();
      // _apiService.clearAuthToken();
      authLogger.d('Local storage cleared on logout');
    }
  }

  // Future<User?> getCurrentUser() async {
  //   authLogger.d('Getting current user');
  //   try {
  //     final userData = await _storageService.getUser();
  //     if (userData == null) {
  //       authLogger.w('No user data found in storage');
  //       return null;
  //     }

  //     final response = await _apiService.get('/auth/me');
  //     if (response.statusCode == 200) {
  //       final user = User.fromJson(response.data);
  //       authLogger.d('Current user retrieved: ${user.name}');
  //       return user;
  //     }
      
  //     return User.fromJson(userData);
  //   } catch (e) {
  //     authLogger.e('Error getting current user: $e');
  //     await _storageService.clearAll();
  //     _apiService.clearAuthToken();
  //     return null;
  //   }
  // }

  // Future<AuthResponse> refreshToken() async {
  //   authLogger.d('Attempting to refresh token');
  //   try {
  //     final refreshToken = await _storageService.getRefreshToken();
  //     if (refreshToken == null) {
  //       authLogger.e('No refresh token available');
  //       throw Exception('No refresh token available');
  //     }

  //     final response = await _apiService.post('/auth/refresh-token', data: {
  //       'refresh_token': refreshToken,
  //     });

  //     if (response.statusCode == 200) {
  //       final authResponse = AuthResponse.fromJson(response.data);
        
  //       // await _storageService.saveToken(authResponse.token);
  //       // await _storageService.saveRefreshToken(authResponse.refreshToken);
        
  //       // _apiService.setAuthToken(authResponse.token);
        
  //       authLogger.i('Token refresh successful');
  //       return authResponse;
  //     } else {
  //       final errorMessage = NetworkExceptions.getErrorMessage(response.data);
  //       authLogger.e('Token refresh failed: $errorMessage');
  //       throw Exception(errorMessage);
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       final errorMessage = NetworkExceptions.handleDioError(e);
  //       authLogger.e('Token refresh Dio error: $errorMessage');
  //       throw Exception(errorMessage);
  //     }
  //     final errorMessage = NetworkExceptions.getErrorMessage(e);
  //     authLogger.e('Token refresh error: $errorMessage');
  //     throw Exception(errorMessage);
  //   }
  // }

  Future<bool> isAuthenticated() async {
    final token = await _storageService.getToken();
    return token != null;
  }

  Future<User?> getStoredUser() async {
    try {
      final userData = await _storageService.getUser();
      if (userData == null) {
        return null;
      }
      final user = User.fromJson(userData);
      return user;
    } catch (e) {
      authLogger.e('Error getting stored user: $e');
      return null;
    }
  }

  // Future<void> restoreToken() async {
  //   try {
  //     final token = await _storageService.getToken();
  //     print('Token from storage: ${token != null ? 'found' : 'not found'}');
  //     if (token != null) {
  //       print('Setting token: ${token.substring(0, 20)}...');
  //       // _apiService.setAuthToken(token);
  //       authLogger.d('Token restored to API service');
  //       print('Token successfully restored to API service');
  //     } else {
  //       print('No token found in storage');
  //     }
  //   } catch (e) {
  //     authLogger.e('Error restoring token: $e');
  //     print('Error restoring token: $e');
  //   }
  // }

  Future<bool> isTokenValid() async {
    try {
      final token = await _storageService.getToken();
      if (token == null) return false;
      
      // Check if token is older than 24 hours
      final tokenTime = await _storageService.getTokenTime();
      if (tokenTime == null) return true; // No timestamp stored, assume valid
      
      final now = DateTime.now();
      final tokenAge = now.difference(DateTime.parse(tokenTime));
      return tokenAge.inHours < 24;
    } catch (e) {
      authLogger.e('Error checking token validity: $e');
      return false;
    }
  }

  Future<void> saveTokenWithTime(String token) async {
    try {
      await _storageService.saveToken(token);
      await _storageService.saveTokenTime(DateTime.now().toIso8601String());
      authLogger.d('Token and time saved');
    } catch (e) {
      authLogger.e('Error saving token with time: $e');
    }
  }

  // Future<void> handleAuthError(String errorMessage) async {
  //   if (errorMessage.toLowerCase().contains('token') || 
  //       errorMessage.toLowerCase().contains('authorization') ||
  //       errorMessage.toLowerCase().contains('Token is not valid') ||
  //       errorMessage.toLowerCase().contains('unauthorized')) {
  //     authLogger.w('Auth error detected, logging out user');
  //     await logout();
  //   }
  // }
}
