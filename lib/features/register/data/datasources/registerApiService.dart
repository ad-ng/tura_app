// import 'package:dio/dio.dart';
// import 'package:tura_app/features/register/data/model/registerModel.dart';
// import 'package:tura_app/models/user_model.dart';
// import 'package:tura_app/network/apiErrorResponse.dart';
// import 'package:tura_app/network/dioService.dart';

// class Registerapiservice {
//   final Dio _dio =
//       DioService.instance.dio; // Use the Dio instance from DioService

//   Future<UserModel> signup(RegisterModel registerModel) async {
//     //try {
//       final response = await _dio.post(
//         '/auth/signup', // Your signup endpoint
//         data: registerModel.toMap(), // Convert RegisterModel to a map
//       );

//       // If the response is successful, parse and return the user data
//       final dataJson = response.data['data'];
//       return UserModel.fromJson(
//           dataJson); // Return the response data as a UserModel
//   //   } on DioException catch (e) {
//   //     // Handle Dio errors and throw a more informative error message
//   //     print('adolphe');
//   //     print(e.response);

//   //     throw _handleError(e).message.join('\n');
//   //   }
//   // }

//   // ApiErrorResponse _handleError(DioException error) {
//   //   // Check if the error has a response and data
//   //   if (error.response != null && error.response!.data != null) {
//   //     try {
//   //       final errorData = error.response!.data;

//   //       // If errorData is already an instance of ApiErrorResponse, return it directly
//   //       if (errorData is ApiErrorResponse) {
//   //         return errorData;
//   //       }

//   //       // Otherwise, try to parse it as a Map<String, dynamic>
//   //       if (errorData is Map<String, dynamic>) {
//   //         return ApiErrorResponse.fromJson(errorData);
//   //       } else {
//   //         print('Unexpected error response format: $errorData');
//   //         return ApiErrorResponse(
//   //           message: ['Unexpected error format'],
//   //           error: 'Unexpected Error',
//   //           statusCode: error.response?.statusCode ?? 500,
//   //         );
//   //       }
//   //     } catch (e) {
//   //       // If parsing fails, log the error and return a generic error response
//   //       print('Failed to parse error response: $e');
//   //       return ApiErrorResponse(
//   //         message: ['Failed to parse error response'],
//   //         error: 'Parsing Error',
//   //         statusCode: error.response?.statusCode ?? 500,
//   //       );
//   //     }
//   //   } else {
//   //     // Handle cases where the error response is not available (e.g., network issues)
//   //     return ApiErrorResponse(
//   //       message: [error.message ?? 'Unknown error occurred'],
//   //       error: 'Network Error',
//   //       statusCode: error.response?.statusCode ?? 500,
//   //     );
//   //   }
//    }
// }

import 'package:dio/dio.dart';
import 'package:tura_app/features/register/data/model/registerModel.dart';
import 'package:tura_app/features/login/data/models/user_model.dart';
import 'package:tura_app/config/network/dioService.dart';

class Registerapiservice {
  final Dio _dio = DioService.instance.dio;

  Future<UserModel> signup(RegisterModel registerModel) async {
    try {
      //print(registerModel.toMap());
      final response = await _dio.post(
        '/auth/signup', // Your signup endpoint
        data: registerModel.toMap(), // Convert RegisterModel to a map
      );

      // If the response is successful, parse and return the user data
      final dataJson = response.data['data'];

      return UserModel.fromJson(
          dataJson); // Return the response data as a UserModel
    } on DioException catch (e) {
      // Simply throw the error, it has already been processed by the interceptor
      print(e);
      throw e.message
          .toString(); // `e.error` should contain the message set by the interceptor
    }
  }
}
