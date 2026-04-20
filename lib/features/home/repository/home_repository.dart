import 'package:tob/core/network/api_service.dart';

class HomeRepository {
  final ApiService _apiService;

  HomeRepository({required ApiService apiService}) : _apiService = apiService;

  Future<dynamic> getDashboardData() async {
    try {
      final response = await _apiService.get('/dashboard');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}