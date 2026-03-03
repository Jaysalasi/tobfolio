import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../utils/logger.dart';

class ApiService {
  late final Dio _dio;
  
  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      sendTimeout: ApiConfig.sendTimeout,
      headers: ApiConfig.headers,
    ));
    
    _setupInterceptors();
  }
  
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          handler.next(response);
        },
        onError: (error, handler) {
          print('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
          handler.next(error);
        },
      ),
    );
    
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        logPrint: (obj) => networkLogger.d(obj.toString()),
      ),
    );
  }
  
  void setAuthToken(String token) {
    networkLogger.d('Setting auth token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
  
  void clearAuthToken() {
    networkLogger.d('Clearing auth token');
    _dio.options.headers.remove('Authorization');
  }
  
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      networkLogger.d('GET request to: $path');
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      networkLogger.i('GET request successful: ${response.statusCode}');
      return response;
    } catch (e) {
      networkLogger.e('GET request failed: $path', error: e);
      rethrow;
    }
  }
  
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      networkLogger.d('POST request to: $path');
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      networkLogger.i('POST request successful: ${response.statusCode}');
      return response;
    } catch (e) {
      networkLogger.e('POST request failed: $path', error: e);
      rethrow;
    }
  }
  
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      networkLogger.d('PUT request to: $path');
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      networkLogger.i('PUT request successful: ${response.statusCode}');
      return response;
    } catch (e) {
      networkLogger.e('PUT request failed: $path', error: e);
      rethrow;
    }
  }
  
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      networkLogger.d('DELETE request to: $path');
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      networkLogger.i('DELETE request successful: ${response.statusCode}');
      return response;
    } catch (e) {
      networkLogger.e('DELETE request failed: $path', error: e);
      rethrow;
    }
  }
  
  Future<Response> postFormData(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      networkLogger.d('POST FormData request to: $path');
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: ApiConfig.formDataHeaders),
      );
      networkLogger.i('POST FormData request successful: ${response.statusCode}');
      return response;
    } catch (e) {
      networkLogger.e('POST FormData request failed: $path', error: e);
      rethrow;
    }
  }
  
  Future<Response> putFormData(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      networkLogger.d('PUT FormData request to: $path');
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: ApiConfig.formDataHeaders),
      );
      networkLogger.i('PUT FormData request successful: ${response.statusCode}');
      return response;
    } catch (e) {
      networkLogger.e('PUT FormData request failed: $path', error: e);
      rethrow;
    }
  }
  
  Dio get dio => _dio;
}
