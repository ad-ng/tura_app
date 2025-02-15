// import 'package:dio/dio.dart';
// import 'package:tura_app/features/login/data/datasources/local/userPreferences.dart';
// import 'package:tura_app/features/shares/data/model/sharemodel.dart';
// import 'package:tura_app/network/dioService.dart';

// class ShareApiService {
//   final Dio _dio = DioService.instance.dio;

//   Future<List<Sharemodel>> fetchSentShares() async {
//     try {
//       final localUser = await UserPreferences().getLocalUser();

//       if (localUser == null) {
//         throw Exception('User not found in local storage');
//       }

//       final response = await _dio.get('/shares/sender/${localUser.id}');

//       final dataJson = response.data['data'];

//       if (dataJson != null && dataJson is List) {
//         return dataJson.map((json) => Sharemodel.fromJson(json)).toList();
//       } else {
//         throw Exception(
//             'Expected a list of shares but got ${dataJson.runtimeType}');
//       }
//     } on DioException catch (e) {
//       throw _handleError(e);
//     } catch (e) {
//       throw Exception('An unexpected error occurred: $e');
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
import 'package:tura_app/features/shares/data/model/createShareModel.dart';
import 'package:tura_app/features/shares/data/model/sharemodel.dart';
import 'package:tura_app/config/network/dioService.dart';

class ShareApiService {
  final Dio _dio = DioService.instance.dio;

  Future<List<Sharemodel>> fetchSentShares() async {
    try {
      final localUser = await UserPreferences().getLocalUser();
      final response = await _dio.get('/shares/sender/${localUser!.id}');

      final dataJson = response.data['data'];

      print('testing share api service');
      if (dataJson != null && dataJson is List) {
        return dataJson.map((json) => Sharemodel.fromJson(json)).toList();
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

  Future<List<UserModel>> fetchAllUsers() async {
    try {
      final response = await _dio.get('/users');

      final dataJson = response.data['data'];

      if (dataJson != null && dataJson is List) {
        return dataJson.map((json) => UserModel.fromJson(json)).toList();
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

  Future<List<Sharemodel>> fetchSharesReceived() async {
    try {
      final localUser = await UserPreferences().getLocalUser();
      final response = await _dio.get('/shares/recipient/${localUser!.id}');

      final dataJson = response.data['data'];

      print('testing share api service');
      if (dataJson != null && dataJson is List) {
        return dataJson.map((json) => Sharemodel.fromJson(json)).toList();
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

  Future<String> createShare(int propertyId, int recipientId) async {
    try {
      final response = await _dio.post('/shares',
          data:
              CreateShareModel(propertyId: propertyId, recipientId: recipientId)
                  .toMap());
      print(response.data['message']);
      return response.data['message'];
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
