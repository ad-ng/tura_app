import 'package:dio/dio.dart';
import 'package:tura_app/features/login/data/datasources/local/tokenStore.dart';
import 'package:tura_app/features/login/data/datasources/local/userPreferences.dart';
import 'package:tura_app/features/login/data/models/login_model.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/config/network/dioService.dart';

class LoginApiService {
  final Dio _dio = DioService.instance.dio;

  // Method to handle login
  Future<UserModel> login(LoginModel loginModel) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: loginModel.toMap(),
      );
      final dataJson = response.data['data'];

      // Save the token using Tokenstore
      Tokenstore.setToken(response.data['token']);

      // Save user in SharedPreferences
      await UserPreferences().saveLocalUser(UserModel.fromJson(dataJson));

      print('shared preferences data');
      final locals = await UserPreferences().getLocalUser();
      print(locals!.fullname);

      // Return the UserModel instance
      return UserModel.fromJson(dataJson);
    } on DioException catch (e) {
      // Handle Dio errors
      throw _handleError(e);
    } catch (e) {
      // Catch other errors (like JSON decoding errors)
      return Future.error('Something went wrong');
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
