import 'package:dio/dio.dart';
import '../../../core/utils/logger.dart';
import '../models/user.dart';
import '../models/login_request.dart';
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

  Future<AuthResponse> login(LoginRequest request) async {
  authLogger.d('Login attempt for email: ${request.email}');
  try {
    final response = await _apiService.post('/auth/login', data: request.toJson());
    
    if (response.statusCode == 200) {
      final authResponse = AuthResponse.fromJson(response.data);
      
      await _storageService.saveToken(authResponse.data.accessToken);
      // Note: Your API doesn't return refresh_token, so you might need to handle this
      await _storageService.saveUser(authResponse.data.user.toJson());
      
      _apiService.setAuthToken(authResponse.data.accessToken);
      
      authLogger.i('Login successful for user: ${authResponse.data.user.fname}');
      return authResponse;
    } else {
      final errorMessage = NetworkExceptions.getErrorMessage(response.data);
      authLogger.e('Login failed: $errorMessage');
      throw Exception(errorMessage);
    }
  } catch (e) {
    if (e is DioException) {
      final errorMessage = NetworkExceptions.handleDioError(e);
      authLogger.e('Login Dio error: $errorMessage');
      throw Exception(errorMessage);
    }
    final errorMessage = NetworkExceptions.getErrorMessage(e);
    authLogger.e('Login error: $errorMessage');
    throw Exception(errorMessage);
  }
}

  Future<AuthResponse> register(RegisterRequest request) async {
    authLogger.d('Registration attempt for email: ${request.email}');
    try {
      final response = await _apiService.post('/auth/register', data: request.toJson());
      
      if (response.statusCode == 201) {
        final authResponse = AuthResponse.fromJson(response.data);
        
        // await _storageService.saveToken(authResponse.token);
        // await _storageService.saveRefreshToken(authResponse.refreshToken);
        // await _storageService.saveUser(authResponse.user.toJson());
        
        _apiService.setAuthToken("authResponse.token");
        
        // authLogger.i('Registration successful for user: ${authResponse.user.fname}');
        return authResponse;
      } else {
        final errorMessage = NetworkExceptions.getErrorMessage(response.data);
        authLogger.e('Registration failed: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = NetworkExceptions.handleDioError(e);
        authLogger.e('Registration Dio error: $errorMessage');
        throw Exception(errorMessage);
      }
      final errorMessage = NetworkExceptions.getErrorMessage(e);
      authLogger.e('Registration error: $errorMessage');
      throw Exception(errorMessage);
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
      _apiService.clearAuthToken();
      authLogger.d('Local storage cleared on logout');
    }
  }

  Future<User?> getCurrentUser() async {
    authLogger.d('Getting current user');
    try {
      final userData = await _storageService.getUser();
      if (userData == null) {
        authLogger.w('No user data found in storage');
        return null;
      }

      final response = await _apiService.get('/auth/me');
      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        authLogger.d('Current user retrieved: ${user.fname}');
        return user;
      }
      
      return User.fromJson(userData);
    } catch (e) {
      authLogger.e('Error getting current user: $e');
      await _storageService.clearAll();
      _apiService.clearAuthToken();
      return null;
    }
  }

  Future<AuthResponse> refreshToken() async {
    authLogger.d('Attempting to refresh token');
    try {
      final refreshToken = await _storageService.getRefreshToken();
      if (refreshToken == null) {
        authLogger.e('No refresh token available');
        throw Exception('No refresh token available');
      }

      final response = await _apiService.post('/auth/refresh-token', data: {
        'refresh_token': refreshToken,
      });

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(response.data);
        
        // await _storageService.saveToken(authResponse.token);
        // await _storageService.saveRefreshToken(authResponse.refreshToken);
        
        // _apiService.setAuthToken(authResponse.token);
        
        authLogger.i('Token refresh successful');
        return authResponse;
      } else {
        final errorMessage = NetworkExceptions.getErrorMessage(response.data);
        authLogger.e('Token refresh failed: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = NetworkExceptions.handleDioError(e);
        authLogger.e('Token refresh Dio error: $errorMessage');
        throw Exception(errorMessage);
      }
      final errorMessage = NetworkExceptions.getErrorMessage(e);
      authLogger.e('Token refresh error: $errorMessage');
      throw Exception(errorMessage);
    }
  }

  Future<bool> isAuthenticated() async {
    final token = await _storageService.getToken();
    return token != null;
  }
}
