import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/logger.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user_data';
  static const String _tokenTimeKey = 'token_time';

  Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      appLogger.d('Token saved successfully');
    } catch (e) {
      appLogger.e('Failed to save token', error: e);
      rethrow;
    }
  }

  Future<String?> getToken() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      appLogger.d('Token retrieved: ${token != null ? 'found' : 'not found'}');
      return token;
    } catch (e) {
      appLogger.e('Failed to retrieve token', error: e);
      return null;
    }
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
      appLogger.d('Refresh token saved successfully');
    } catch (e) {
      appLogger.e('Failed to save refresh token', error: e);
      rethrow;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      appLogger.d('Refresh token retrieved: ${refreshToken != null ? 'found' : 'not found'}');
      return refreshToken;
    } catch (e) {
      appLogger.e('Failed to retrieve refresh token', error: e);
      return null;
    }
  }

  Future<void> saveUser(Map<String, dynamic> userData) async {
    try {
      await _storage.write(key: _userKey, value: jsonEncode(userData));
      appLogger.d('User data saved successfully');
    } catch (e) {
      appLogger.e('Failed to save user data', error: e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUser() async {
    try {
      final userData = await _storage.read(key: _userKey);
      if (userData != null) {
        final userMap = jsonDecode(userData) as Map<String, dynamic>;
        appLogger.d('User data retrieved successfully');
        return userMap;
      }
      appLogger.d('No user data found');
      return null;
    } catch (e) {
      appLogger.e('Failed to retrieve user data', error: e);
      return null;
    }
  }

  Future<void> saveTokenTime(String time) async {
    try {
      await _storage.write(key: _tokenTimeKey, value: time);
      appLogger.d('Token time saved');
    } catch (e) {
      appLogger.e('Failed to save token time', error: e);
    }
  }

  Future<String?> getTokenTime() async {
    try {
      final tokenTime = await _storage.read(key: _tokenTimeKey);
      appLogger.d('Token time retrieved: ${tokenTime != null ? 'found' : 'not found'}');
      return tokenTime;
    } catch (e) {
      appLogger.e('Failed to retrieve token time', error: e);
      return null;
    }
  }

  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
      appLogger.d('All secure storage data cleared');
    } catch (e) {
      appLogger.e('Failed to clear secure storage', error: e);
      rethrow;
    }
  }

  Future<void> deleteToken() async {
    try {
      await _storage.delete(key: _tokenKey);
      appLogger.d('Token deleted successfully');
    } catch (e) {
      appLogger.e('Failed to delete token', error: e);
      rethrow;
    }
  }

  Future<void> deleteRefreshToken() async {
    try {
      await _storage.delete(key: _refreshTokenKey);
      appLogger.d('Refresh token deleted successfully');
    } catch (e) {
      appLogger.e('Failed to delete refresh token', error: e);
      rethrow;
    }
  }

  Future<void> deleteUser() async {
    try {
      await _storage.delete(key: _userKey);
      appLogger.d('User data deleted successfully');
    } catch (e) {
      appLogger.e('Failed to delete user data', error: e);
      rethrow;
    }
  }

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<bool> hasRefreshToken() async {
    final refreshToken = await getRefreshToken();
    return refreshToken != null && refreshToken.isNotEmpty;
  }

  Future<bool> hasUserData() async {
    final userData = await getUser();
    return userData != null;
  }
}
