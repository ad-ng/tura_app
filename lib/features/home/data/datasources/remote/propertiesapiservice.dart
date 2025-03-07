import 'package:dio/dio.dart';
import 'package:tura_app/features/home/data/models/properties_model.dart';
import 'package:tura_app/config/network/dioService.dart';

class PropertiesApiService {
  final Dio _dio = DioService.instance.dio;

  Future<PropertiesModel> fetchSingleProp(String slug) async {
    try {
      final response = await _dio.get('/properties/$slug');

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

  Future<List<PropertiesModel>> fetchProps(int page) async {
    try {
      final response = await _dio.get(
        '/properties',
        queryParameters: {
          'page': page,
          'limit': 10,
        },
      );

      final dataJson = response.data['data'];

      if (dataJson != null && dataJson is List) {
        return dataJson.map((json) => PropertiesModel.fromJson(json)).toList();
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

  Future<List<PropertiesModel>> similarProps(String id) async {
    try {
      final response = await _dio.get('/properties/$id/similar');

      final dataJson = response.data['data'];

      if (dataJson != null && dataJson is List) {
        return dataJson.map((json) => PropertiesModel.fromJson(json)).toList();
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

  Future<List<PropertiesModel>> filterProperties() async {
    try {
      final response = await _dio.get(
        '/properties/search?hasParking=true&isForSale=true',
        // queryParameters: {
        //   'page': page,
        //   'limit': 4,
        // },
      );

      final dataJson = response.data['data'];

      if (dataJson != null && dataJson is List) {
        return dataJson.map((json) => PropertiesModel.fromJson(json)).toList();
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
