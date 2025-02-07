import 'package:dio/dio.dart';
import 'package:tura_app/network/dioService.dart';

class Fetchallproperties {
  
  final Dio _dio = DioService.instance.dio;

  // Method to handle login
  Future<UserModel> login(LoginModel loginModel) async {
    try {
      final response = await _dio.post(
        '/auth/login', // Your login endpoint
        data: loginModel.toMap(), // Convert LoginModel to a map
      );
      final dataJson = response.data['data'];

      Tokenstore.setToken(response.data['token']);

      return UserModel.fromJson(dataJson); // Return the response data
    } on DioException catch (e) {
      // Handle Dio errors
      throw _handleError(e);
    }
  }
  }