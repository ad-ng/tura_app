import 'package:dio/dio.dart';
import 'package:tura_app/features/login/data/datasources/local/userPreferences.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/network/dioService.dart';

class UserApiService {
  final Dio _dio = DioService.instance.dio;

  Future<UserModel> fetchUserByUsername() async {
    final localUser = await UserPreferences().getLocalUser();
    final userName = localUser!.username;
    try {
      final response = await _dio.get('/users/$userName');

      final dataJson = response.data['data'];

      if (dataJson != null) {
        await UserPreferences().saveLocalUser(UserModel.fromJson(dataJson));
        return UserModel.fromJson(dataJson);
      } else {
        throw Exception(
            'Expected an object of user but got ${dataJson.runtimeType}');
      }
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw 'An unexpected error occurred: $e';
    }
  }

  // Handle Dio errors
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badResponse:
        return 'Incorrect email or password';
      case DioExceptionType.cancel:
        return 'Request canceled';
      case DioExceptionType.unknown:
        return 'Unknown error: ${error.message}';
      default:
        return 'Something went wrong';
    }
  }
}
