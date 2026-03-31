class ApiConfig {
  static const String baseUrl = 'https://tobfolio-db-1.onrender.com/api/v1';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  
  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  
  static const Map<String, String> formDataHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'multipart/form-data',
  };
}
