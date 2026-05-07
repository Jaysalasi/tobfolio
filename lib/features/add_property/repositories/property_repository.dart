import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tobfolio/core/network/api_service.dart';
import 'package:tobfolio/core/services/media_upload_service.dart';

class PropertyRepository {
  final ApiService _apiService;
  final MediaUploadService _mediaUploadService;

  PropertyRepository(this._apiService, this._mediaUploadService);

  Future<Map<String, dynamic>> createProperty({
    required String name,
    required String type,
    required String address,
    required int units,
    required List<String> propertyImages,
    required String managementType,
    required String unitType,
    String unitNumber = '',
    int totalUnits = 0,
    String unitDescription = '',
  }) async {
    try {
      // Upload all property images first
      final List<String> uploadedImageUrls = [];

      for (final imagePath in propertyImages) {
        try {
          final fileName = imagePath.split('/').last;
          final uploadedUrl = await _mediaUploadService.uploadFile(
            filePath: imagePath,
            fileName: fileName,
          );
          uploadedImageUrls.add(uploadedUrl);
        } catch (e) {
          // Continue with other images, but you might want to handle this differently
        }
      }

      final requestData = {
        'name': name,
        'type': type,
        'address': address,
        'units': units,
        'propertyImages': uploadedImageUrls,
        'managementType': managementType,
        'unitType': unitType,
        'unitNumber': unitNumber,
        'totalUnits': totalUnits,
        'unitDescription': unitDescription,
      };

      debugPrint('Request Data: $requestData'); // Debugging log

      final response = await _apiService.post('/properties', data: requestData);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: '/properties'),
          // response: response,
          message: 'Failed to create property: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/properties'),
        message: 'Network error: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
