import 'package:dio/dio.dart';
import 'package:tura_app/config/network/dioService.dart';
import 'package:tura_app/features/notification/data/model/notificationModel.dart';

class NotificationApiService {
  final Dio _dio = DioService.instance.dio;

  Future<List<NotificationModel>> fetchAllNotifications() async {
    try {
      final response = await _dio.get('/notifications');

      final dataJson = response.data;

      if (dataJson != null && dataJson is List) {
        return dataJson.map((json) => NotificationModel.fromMap(json)).toList();
      } else {
        throw Exception(
            'Expected a list of properties but got ${dataJson.runtimeType}');
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
