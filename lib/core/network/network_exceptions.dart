import 'package:dio/dio.dart';

class NetworkExceptions {
  static String getErrorMessage(dynamic error) {
    if (error is String) {
      return error;
    }
    
    if (error is Map) {
      return error['message'] ?? 'An unknown error occurred $error';
    }
    
    return 'An unknown error occurred $error';
  }
  
  static String handleDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Response timeout. Please try again.';
      case DioExceptionType.badResponse:
        return _handleHttpError(dioError.response?.statusCode ?? 0, dioError.response?.data['message'] ?? dioError.response?.data['error'] ?? 'An unknown error occurred');
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.unknown:
        return 'Network error. Please check your internet connection.';
      default:
        return 'An unexpected error occurred.';
    }
  }
  
  static String _handleHttpError(int statusCode, String message) {
    switch (statusCode) {
      case 400:
        return message;
      case 401:
        return 'Unauthorized. $message';
      case 403:
        return 'Forbidden. $message';
      case 404:
        return 'Not found. $message';
      case 422:
        return 'Validation error $statusCode. $message.';
      case 500:
        return 'Internal server error. $message';
      case 503:
        return 'Service unavailable. $message';
      default:
        return 'HTTP error: $statusCode';
    }
  }
}
