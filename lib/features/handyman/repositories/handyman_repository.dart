import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
          requestOptions: RequestOptions(path: '/handymen'),
          // response: response,
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
          requestOptions: RequestOptions(path: '/handymen/$id'),
          // response: response,
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

  Future<Map<String, dynamic>> createReview(String handymanId, Map<String, dynamic> reviewData) async {
    try {
      final response = await _apiService.post('/handymen/$handymanId/reviews', data: reviewData);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: '/handymen/$handymanId/reviews'),
          // response: response,
          message: 'Failed to create review: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      
      // Check if it's an auth error and handle automatically
      if (e.response?.data != null && 
          e.response!.data.toString().toLowerCase().contains('authorization')) {
        if (kDebugMode) {
          print('Auth error detected - should trigger logout');
        }
        // This will be handled by the BLoC consumer
      }
      
      throw DioException(
        requestOptions: e.requestOptions,
        message: 'Network error: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
