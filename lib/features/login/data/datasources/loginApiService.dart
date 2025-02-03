import 'package:dio/dio.dart';
import 'package:tura_app/features/login/data/models/login_model.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/network/dioService.dart';
//import 'dio_service.dart'; // Import your DioService
//import 'login_model.dart'; // Import your LoginModel

class LoginApiService {
  final Dio _dio =
      DioService.instance.dio; // Use the Dio instance from DioService

  // Method to handle login
  Future<UserModel> login(LoginModel loginModel) async {
    try {
      final response = await _dio.post(
        '/auth/login', // Your login endpoint
        data: loginModel.toMap(), // Convert LoginModel to a map
      );
      final dataJson = response.data['data'];
      return UserModel.fromJson(dataJson); // Return the response data
    } on DioException catch (e) {
      // Handle Dio errors
      throw _handleError(e);
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
