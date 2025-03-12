import 'package:dio/dio.dart';
import 'package:tura_app/config/network/dioService.dart';

class NotificationApiService {
  final Dio _dio = DioService.instance.dio;

  Future fetchAllNotifications() async {
    try {
      final response = await _dio.get('/notifications');

      final dataJson = response.data['data'];

      if (dataJson != null && dataJson is Map<String, dynamic>) {
        return PropertiesModel.fromJson(dataJson);
      } else {
        throw Exception(
            'Expected a JSON object but got ${dataJson.runtimeType}');
      }
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw 'An unexpected error occurred: $e';
    }
  }

  // Handle Dio-specific errors
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badResponse:
        return 'Bad response: ${error.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Request canceled';
      case DioExceptionType.unknown:
        return 'Unknown error: ${error.message}';
      default:
        return 'Something went wrong';
    }
  }
}
