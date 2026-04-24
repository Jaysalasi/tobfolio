import '../../../core/network/api_service.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository({required ApiService apiService}) : _apiService = apiService;

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String about,
    required String currency,
  }) async {
    final response = await _apiService.put(
      '/user/profile',
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'about': about,
        'currency': currency,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.message ?? 'Failed to update profile');
    }
  }

  Future<void> updateCurrency(String currency) async {
    final response = await _apiService.put(
      '/user/currency',
      data: {'currency': currency},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.message ?? 'Failed to update currency');
    }
  }
}
