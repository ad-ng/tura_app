import 'package:dio/dio.dart';
import 'package:tura_app/features/home/data/models/properties_model.dart';
import 'package:tura_app/network/dioService.dart';

class FetchAllProperties {
  final Dio _dio = DioService.instance.dio;

  Future<List<PropertiesModel>> fetchProps() async {
    try {
      final response = await _dio.get('properties');

      final dataJson = response.data['data'];

      if (dataJson is List) {
        return dataJson.map((json) => PropertiesModel.fromJson(json)).toList();
      } else {
        throw Exception('Expected a list but got ${dataJson.runtimeType}');
      }
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw 'An unexpected error occurred: $e';
    }
  }

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
