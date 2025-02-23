import 'package:dio/dio.dart';
import 'package:tura_app/features/favorites/data/models/favoritesModel.dart';
import 'package:tura_app/config/network/dioService.dart';

class Favoritesapiservice {
  final Dio _dio = DioService.instance.dio;

  Future<List<Favoritesmodel>> fetchAllFavorites() async {
    try {
      final response = await _dio.get('/favorites');

      final dataJson = response.data;

      if (dataJson != null && dataJson is List) {
        return dataJson.map((json) => Favoritesmodel.fromMap(json)).toList();
      } else {
        throw Exception(
            'Expected a list of properties but got ${dataJson.runtimeType}');
      }
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      // You could enhance this error further with specific error handling
      throw 'An unexpected error occurred: $e';
    }
  }

  Future deleteFavorite(propertyId) async {
    try {
      await _dio.delete('/favorites/${propertyId}');
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      // You could enhance this error further with specific error handling
      throw 'An unexpected error occurred: $e';
    }
  }

  Future<bool> checkFavorite(propertyId) async {
    try {
      final response = await _dio.delete('/favorites/check/${propertyId}');
      return response.data['isFavorite'];
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      // You could enhance this error further with specific error handling
      throw 'An unexpected error occurred: $e';
    }
  }

  Future addFavorite(propertyId, favoriteStatus) async {
    try {
      await _dio.post('/favorites/check/${propertyId}',
          data: {"isFavorite": favoriteStatus});
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      // You could enhance this error further with specific error handling
      throw 'An unexpected error occurred: $e';
    }
  }

  // Handle Dio-specific errors
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your network and try again.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. The server is taking too long to respond.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. The server is taking too long to send data.';
      case DioExceptionType.badResponse:
        if (error.response != null) {
          // Handle specific status codes
          if (error.response?.statusCode == 404) {
            return 'The requested resource was not found.';
          }
          return 'Bad response: ${error.response?.statusCode}';
        }
        return 'Bad response with no status code';
      case DioExceptionType.cancel:
        return 'Request was canceled by the user.';
      case DioExceptionType.unknown:
        return 'Unknown error: ${error.message}';
      default:
        return 'Something went wrong';
    }
  }
}
