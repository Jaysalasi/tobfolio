import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:tobfolio/core/storage/secure_storage_service.dart';
import '../config/api_config.dart';
import '../utils/logger.dart';

class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  @override
  String toString() {
    return 'ApiResponse(success: $success, statusCode: $statusCode, message: $message, data: $data)';
  }
}

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
        headers: ApiConfig.headers,

        // 🔥 IMPORTANT: ensures ALL responses reach onResponse
        validateStatus: (status) => true,
      ),
    );

    _setupInterceptors();
  }
bool _isLoggingOut = false;

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageService().getToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          networkLogger.d('--> ${options.method} ${options.uri}');
          networkLogger.d('Headers: ${options.headers}');
          // if (options.data != null) {
          //   networkLogger.d('Body: ${options.data}');
          // }

          handler.next(options);
        },
        onResponse: (response, handler) async {
          networkLogger.i(
            '<-- ${response.statusCode} ${response.requestOptions.uri}',
          );
          networkLogger.d('Response: ${response.data}');
          final statusCode = response.statusCode;

        networkLogger.i(
          '<-- $statusCode ${response.requestOptions.uri}',
        );

        if (statusCode == 401 && !_isLoggingOut) {
          _isLoggingOut = true;

          networkLogger.w('401 detected → logging out user');

          await SecureStorageService().clearAll();

          AuthHandler.logout();
        }
          handler.next(response);
        },
        onError: (err, handler) async {
          networkLogger.e(
            '<-- ERROR ${err.response?.statusCode} ${err.requestOptions.uri}',
          );
          networkLogger.e('Error: ${err.message}');
          if (err.response?.statusCode == 401) {
            networkLogger.w('Unauthorized! Logging out user...');
            // clear token
            await SecureStorageService().clearAll();
            // trigger app-level logout
            AuthHandler.logout();
          }
          handler.next(err);
        },
      ),
    );
  }

  // ===============================
  // ERROR HANDLER
  // ===============================
  String _handleDioError(DioException err) {
    if (err.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout. Please check your internet.';
    } else if (err.type == DioExceptionType.sendTimeout) {
      return 'Send timeout. Try again.';
    } else if (err.type == DioExceptionType.receiveTimeout) {
      return 'Server took too long to respond.';
    } else if (err.type == DioExceptionType.badResponse) {
      final data = err.response?.data;

      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }

      if (data is Map && data['error'] != null) {
        return data['error'].toString();
      }

      return 'Server error (${err.response?.statusCode})';
    } else if (err.type == DioExceptionType.cancel) {
      return 'Request cancelled';
    } else {
      if (err.error is SocketException) {
        return 'No internet connection';
      }
      return 'Unexpected error: ${err.message}';
    }
  }

  // ===============================
  // GENERIC REQUEST HANDLER
  // ===============================
  Future<ApiResponse<T>> _request<T>(
    Future<Response> Function() request, {
    T Function(dynamic data)? decoder,
  }) async {
    try {
      final response = await request();

      final parsed = decoder != null
          ? decoder(response.data)
          : response.data as T?;

      return ApiResponse<T>(
        success: true,
        data: parsed,
        statusCode: response.statusCode,
      );
    } on DioException catch (err) {
      final msg = _handleDioError(err);
      return ApiResponse<T>(
        success: false,
        message: msg,
        statusCode: err.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse<T>(success: false, message: e.toString());
    }
  }

  // ===============================
  // METHODS
  // ===============================

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic data)? decoder,
  }) {
    return _request<T>(
      () => _dio.get(path, queryParameters: queryParameters, options: options),
      decoder: decoder,
    );
  }

  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic data)? decoder,
  }) {
    return _request<T>(
      () => _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      decoder: decoder,
    );
  }

  Future<ApiResponse<T>> postFormData<T>(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic data)? decoder,
  }) {
    return _request<T>(
      () => _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: ApiConfig.formDataHeaders),
      ),
      decoder: decoder,
    );
  }

  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic data)? decoder,
  }) {
    return _request<T>(
      () => _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      decoder: decoder,
    );
  }

  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic data)? decoder,
  }) {
    return _request<T>(
      () => _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      decoder: decoder,
    );
  }
}

class AuthHandler {
  static VoidCallback? onUnauthorized;

  static void logout() {
    if (onUnauthorized != null) {
      onUnauthorized!();
    }
  }
}
