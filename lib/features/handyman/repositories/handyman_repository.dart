import 'package:dio/dio.dart';
import '../../../core/network/api_service.dart';
import '../models/handyman.dart';

class HandymanRepository {
  final ApiService _apiService;

  HandymanRepository({required ApiService apiService}) : _apiService = apiService;

  Future<List<Handyman>> getHandymen({
    String? expertise,
    String? location,
    String? search,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};
      
      if (expertise != null && expertise.isNotEmpty) {
        queryParams['expertise'] = expertise;
      }
      if (location != null && location.isNotEmpty) {
        queryParams['location'] = location;
      }
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await _apiService.get(
        '/handymen',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Handyman.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load handymen: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        message: 'Network error: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Map<String, dynamic>> getHandymanById(String id) async {
    try {
      final response = await _apiService.get('/handymen/$id');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load handyman: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        message: 'Network error: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
