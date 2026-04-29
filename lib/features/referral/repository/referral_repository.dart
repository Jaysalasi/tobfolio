import 'package:tobfolio/core/network/api_service.dart';

class ReferralRepository {
  final ApiService _apiService;
  
  ReferralRepository({required ApiService apiService}) : _apiService = apiService;

  Future<dynamic> getReferralData() async {
    try {
      final response = await _apiService.get('/rewards/me');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
