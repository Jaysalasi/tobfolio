import 'package:tob/core/network/api_service.dart';
import 'package:tob/core/services/media_upload_service.dart';

class TenantRepository {
  final ApiService _apiService;
  final MediaUploadService _mediaUploadService;

  TenantRepository(this._apiService, this._mediaUploadService);

  Future<void> createTenant({
    required String name,
    required String email,
    required String phone,
    required String propertyId,
    required String unitNumber,
    required double rentAmount,
    required String rentStart,
    required String rentEnd,
    required String rentDuration,
    required String paymentFrequency,
    String? imagePath,
    String? notes,
  }) async {
    try {
      // Upload image if provided
      String? imageUrl;
      if (imagePath != null) {
        final fileName = imagePath.split('/').last;
        imageUrl = await _mediaUploadService.uploadFile(
          filePath: imagePath,
          fileName: fileName,
        );
      }

      // Create tenant request body
      final requestBody = {
        'name': name,
        'email': email,
        'phone': phone,
        'propertyId': propertyId,
        'unitNumber': unitNumber,
        'rentAmount': rentAmount,
        'rentStart': rentStart,
        'rentEnd': rentEnd,
        'rentDuration': rentDuration,
        'paymentFrequency': paymentFrequency,
        'image': imageUrl ?? '',
        'notes': notes ?? '',
      };

      // Make POST request to create tenant
      final response = await _apiService.post('/tenants', data: requestBody);
      
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('Failed to create tenant: ${response.statusCode}');
      }
      
      print('Tenant created successfully: ${response.data}');
    } catch (e) {
      print('Error creating tenant: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getTenantById(String tenantId) async {
    try {
      final response = await _apiService.get('/tenants/$tenantId');
      
      if (response.statusCode == 200) {
        final responseData = response.data;
        
        // Handle direct object response
        if (responseData is Map) {
          return responseData.cast<String, dynamic>();
        } 
        // Handle wrapped response structure
        else if (responseData is Map && responseData.containsKey('data')) {
          final tenantData = responseData['data'] as Map<String, dynamic>;
          return tenantData;
        } else {
          throw Exception('Invalid response format: expected object or object with data field');
        }
      } else {
        throw Exception('Failed to fetch tenant: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tenant: $e');
      rethrow;
    }
  }

  Future<void> updateTenant(String tenantId, Map<String, dynamic> updatedData) async {
    print('DEBUG: Repository.updateTenant called');
    print('DEBUG: tenantId: $tenantId');
    print('DEBUG: endpoint: /tenants/$tenantId');
    print('DEBUG: updatedData: $updatedData');
    
    try {
      print('DEBUG: Making PUT request to /tenants/$tenantId');
      final response = await _apiService.put('/tenants/$tenantId', data: updatedData);
      
      print('DEBUG: Response status code: ${response.statusCode}');
      print('DEBUG: Response data: ${response.data}');
      
      if (response.statusCode == 200) {
        print('DEBUG: Tenant updated successfully: ${response.data}');
      } else {
        print('DEBUG: Failed to update tenant: ${response.statusCode}');
        throw Exception('Failed to update tenant: ${response.statusCode}');
      }
    } catch (e) {
      print('DEBUG: Error updating tenant: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getTenants() async {
    try {
      final response = await _apiService.get('/tenants');
      
      if (response.statusCode == 200) {
        final responseData = response.data;
        
        // Handle direct array response (as shown in logs)
        if (responseData is List) {
          return responseData.cast<Map<String, dynamic>>();
        } 
        // Handle wrapped response structure
        else if (responseData is Map && responseData.containsKey('data')) {
          final tenantsData = responseData['data'] as List<dynamic>;
          return tenantsData.cast<Map<String, dynamic>>();
        } else {
          throw Exception('Invalid response format: expected array or object with data field');
        }
      } else {
        throw Exception('Failed to fetch tenants: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tenants: $e');
      rethrow;
    }
  }
}
