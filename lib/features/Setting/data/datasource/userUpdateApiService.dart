import 'package:dio/dio.dart';
import 'package:tura_app/features/Setting/data/model/updateUserModel.dart';
import 'package:tura_app/features/login/data/datasources/local/userPreferences.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/config/network/dioService.dart';

class UserUpdateApiService {
  final Dio _dio = DioService.instance.dio;

  Future<UserModel> updateUser(
      UpdateUserModel updateUserModel, userName) async {
    try {
      final response = await _dio.patch(
        '/users/$userName',
        data: updateUserModel.toMap(), // Convert RegisterModel to a map
      );

      // If the response is successful, parse and return the user data
      final dataJson = response.data['data'];

      await UserPreferences().saveLocalUser(UserModel.fromJson(dataJson));
      print(dataJson);
      return UserModel.fromJson(dataJson);
    } on DioException catch (e) {
      // Simply throw the error, it has already been processed by the interceptor
      print(e);
      throw e.message
          .toString(); // `e.error` should contain the message set by the interceptor
    }
  }
}
