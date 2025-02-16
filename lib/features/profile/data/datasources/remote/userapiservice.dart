// import 'package:dio/dio.dart';
// import 'package:tura_app/features/login/data/datasources/local/userPreferences.dart';
// import 'package:tura_app/features/login/data/models/user_model.dart';
// import 'package:tura_app/network/dioService.dart';

// class UserApiService {
//   final Dio _dio = DioService.instance.dio;

//   Future<UserModel> fetchUserByUsername() async {
//     //final localUser = await UserPreferences().getLocalUser();
//     //final userName = localUser!.username;

//     try {
//       final response = await _dio.get('/users/johndoe');

//       final dataJson = response.data['data'];

//       if (dataJson) {
//         //await UserPreferences().saveLocalUser(UserModel.fromJson(dataJson));
//         //return UserModel.fromJson(dataJson);
//         return response.data['message'];
//       } else {
//         throw Exception(
//             'Expected an object of user but got ${dataJson.runtimeType}');
//       }
//     } on DioException catch (e) {
//       throw _handleError(e);
//     } catch (e) {
//       throw 'An unexpected error occurred: ${e.toString()}';
//     }
//   }

//   // Handle Dio errors
//   String _handleError(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//         return 'Connection timeout';
//       case DioExceptionType.sendTimeout:
//         return 'Send timeout';
//       case DioExceptionType.receiveTimeout:
//         return 'Receive timeout';
//       case DioExceptionType.badResponse:
//         return 'Incorrect email or password';
//       case DioExceptionType.cancel:
//         return 'Request canceled';
//       case DioExceptionType.unknown:
//         return 'Unknown error: ${error.message}';
//       default:
//         return 'Something went wrong';
//     }
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:tura_app/features/home/data/models/properties_model.dart';
// import 'package:tura_app/network/dioService.dart';

// class FetchAllProperties {
//   final Dio _dio = DioService.instance.dio;

//   //Future<List<PropertiesModel>> fetchProps() async {
//   Future<PropertiesModel> fetchProps() async {
//     try {
//       final response = await _dio.get('/properties/cozy-studio');

//       final dataJson = response.data['data'];

//       // if (dataJson is List) {
//       //   return dataJson.map((json) => PropertiesModel.fromJson(json)).toList();
//       // }
//       if (dataJson) {
//         return PropertiesModel.fromJson(dataJson);
//       } else {
//         throw Exception('Expected a list but got ${dataJson.runtimeType}');
//       }
//     } on DioException catch (e) {
//       throw _handleError(e);
//     } catch (e) {
//       throw 'An unexpected error occurred: $e';
//     }
//   }

//   String _handleError(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//         return 'Connection timeout';
//       case DioExceptionType.sendTimeout:
//         return 'Send timeout';
//       case DioExceptionType.receiveTimeout:
//         return 'Receive timeout';
//       case DioExceptionType.badResponse:
//         return 'Bad response: ${error.response?.statusCode}';
//       case DioExceptionType.cancel:
//         return 'Request canceled';
//       case DioExceptionType.unknown:
//         return 'Unknown error: ${error.message}';
//       default:
//         return 'Something went wrong';
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:tura_app/features/login/data/datasources/local/userPreferences.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/config/network/dioService.dart';

class UserApiService {
  final Dio _dio = DioService.instance.dio;

  Future<UserModel> fetchUserByUsername() async {
    try {
      final localUser = await UserPreferences().getLocalUser();
      final response = await _dio.get('/users/${localUser!.username}');

      final dataJson = response.data['data'];

      if (dataJson != null && dataJson is Map<String, dynamic>) {
        return UserModel.fromJson(dataJson);
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
