import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tob/core/network/api_service.dart';

class MediaUploadService {
  final ApiService _apiService;

  MediaUploadService(this._apiService);

  Future<String> uploadFile({
    required String filePath,
    required String fileName,
    String? contentType,
  }) async {
    try {
      final file = File(filePath);
      if (!file.existsSync()) {
        throw Exception('File does not exist: $filePath');
      }

      // Determine content type if not provided
      if (contentType == null) {
        final extension = fileName.split('.').last.toLowerCase();
        switch (extension) {
          case 'jpg':
          case 'jpeg':
            contentType = 'image/jpeg';
            break;
          case 'png':
            contentType = 'image/png';
            break;
          case 'gif':
            contentType = 'image/gif';
            break;
          case 'pdf':
            contentType = 'application/pdf';
            break;
          case 'doc':
            contentType = 'application/msword';
            break;
          case 'docx':
            contentType = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
            break;
          default:
            contentType = 'application/octet-stream';
        }
      }

      // Create multipart form data
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: DioMediaType.parse(contentType),
        ),
      });

      final response = await _apiService.postFormData('/upload', data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data as Map<String, dynamic>;
        
        if (responseData['success'] == true && responseData['url'] != null) {
          final uploadedUrl = responseData['url'] as String;
          return uploadedUrl;
        } else {
          throw Exception('Upload failed: ${responseData['message'] ?? 'Unknown error'}');
        }
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: '/upload'),
          // response: response,
          message: 'Failed to upload file: ${response.statusCode}',
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

  Future<List<String>> uploadMultipleFiles({
    required List<String> filePaths,
    Map<String, String>? fileNames,
  }) async {
    final List<String> uploadedUrls = [];
    
    for (int i = 0; i < filePaths.length; i++) {
      final filePath = filePaths[i];
      final fileName = fileNames?[filePath] ?? filePath.split('/').last;
      
      try {
        final url = await uploadFile(
          filePath: filePath,
          fileName: fileName,
        );
        uploadedUrls.add(url);
      } catch (e) {
        // Continue with other files, but you might want to handle this differently
      }
    }
    
    return uploadedUrls;
  }
}
