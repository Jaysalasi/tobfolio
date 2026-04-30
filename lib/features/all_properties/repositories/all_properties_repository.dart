import 'package:dio/dio.dart';
import 'package:tobfolio/core/network/api_service.dart';
import 'package:tobfolio/features/all_properties/model/all_property_model.dart';

class AllPropertiesRepository {
  final ApiService _apiService;

  AllPropertiesRepository(this._apiService);

  Future<List<PropertyModel>> getAllProperties() async {
    try {
      final response = await _apiService.get('/properties');
      
      if (response.statusCode == 200) {
      
        final List<dynamic> data = response.data;
        return data.map((json) => PropertyModel.fromJson(json)).toList();
          // return propertiesData.cast<Map<String, dynamic>>();
       
      } else {
        throw DioException(
        requestOptions:  RequestOptions(path: '/properties'),
          message: 'Failed to fetch properties: ${response.statusCode}',  
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

  Future<void> deleteProperty(String propertyId) async {
    try {
      final response = await _apiService.delete('/properties/$propertyId');
      
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Property deleted successfully
        return;
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: '/properties/$propertyId'),
          message: 'Failed to delete property: ${response.statusCode}',  
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
