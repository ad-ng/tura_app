import 'package:dio/dio.dart';
import 'package:tura_app/models/login_model.dart';
import 'package:tura_app/network/dioService.dart';
//import 'dio_service.dart'; // Import your DioService
//import 'login_model.dart'; // Import your LoginModel

class LoginRepository {
  final Dio _dio =
      DioService.instance.dio; // Use the Dio instance from DioService

  // Method to handle login
  Future<dynamic> login(LoginModel loginModel) async {
    try {
      final response = await _dio.post(
        '/auth/login', // Your login endpoint
        data: loginModel.toMap(), // Convert LoginModel to a map
      );
      return response.data; // Return the response data
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
