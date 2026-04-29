import 'package:tobfolio/core/network/api_service.dart';
import 'package:tobfolio/core/storage/secure_storage_service.dart';
import 'package:tobfolio/features/auth/models/user.dart';

class HomeRepository {
  final ApiService _apiService;
  // final SecureStorageService _storageService;
  HomeRepository({
    required ApiService apiService,
    // required SecureStorageService storageService,
  }) : _apiService = apiService;
      //  _storageService = storageService;

  Future<dynamic> getDashboardData() async {
    try {
      final response = await _apiService.get('/dashboard');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getUserData() async {
    try {
      final response = await _apiService.get('/user/profile');
      final userResponse = await _apiService.get('/user/profile');
      final user = User.fromJson(userResponse.data);
      await SecureStorageService().saveUser(user.toJson());

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
