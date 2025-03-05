import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tura_app/features/login/data/datasources/local/userPreferences.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/config/network/dioService.dart';
import 'package:tura_app/features/setting/data/model/updateUserMoodel.dart';

class UserUpdateApiService {
  final Dio _dio = DioService.instance.dio;

  Future<UserModel> updateUser(
      UpdateUserModel updateUserModel, userName) async {
    try {
      final response = await _dio.patch(
        '/users/$userName',
        data: updateUserModel.toMap(),
      );

      // If the response is successful, parse and return the user data
      final dataJson = response.data['data'];

      await UserPreferences().saveLocalUser(UserModel.fromJson(dataJson));
      print(dataJson);
      return UserModel.fromJson(dataJson);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw 'An unexpected error occurred: $e';
    }
  }

  Future updateImage(userName, File profileImage) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(profileImage.path,
          filename: 'profileImage'),
    });
    try {
      final response = await _dio.post(
        '/users/$userName/upload',
        data: formData,
      );

      return response.data;
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
