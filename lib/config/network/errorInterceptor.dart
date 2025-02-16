// import 'package:dio/dio.dart';
// import 'package:tura_app/network/apiErrorResponse.dart';

// class ErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     // Handle Dio errors globally
//     final apiError = _handleError(err);
//     handler.reject(
//       DioException(
//         requestOptions: err.requestOptions,
//         response: err.response,
//         type: err.type,
//         error: apiError,
//         message: apiError.message.join('\n'),
//       ),
//     );
//   }

//   ApiErrorResponse _handleError(DioException error) {
//     // Check if the error has a response and data
//     if (error.response != null && error.response!.data != null) {
//       try {
//         final errorData = error.response!.data;

//         // If errorData is already an instance of ApiErrorResponse, return it directly
//         if (errorData is ApiErrorResponse) {
//           return errorData;
//         }

//         // Otherwise, try to parse it as a Map<String, dynamic>
//         if (errorData is Map<String, dynamic>) {
//           return ApiErrorResponse.fromJson(errorData);
//         } else {
//           print('Unexpected error response format: $errorData');
//           return ApiErrorResponse(
//             message: ['Unexpected error format'],
//             error: 'Unexpected Error',
//             statusCode: error.response?.statusCode ?? 500,
//           );
//         }
//       } catch (e) {
//         // If parsing fails, log the error and return a generic error response
//         print('Failed to parse error response: $e');
//         return ApiErrorResponse(
//           message: ['Failed to parse error response'],
//           error: 'Parsing Error',
//           statusCode: error.response?.statusCode ?? 500,
//         );
//       }
//     } else {
//       // Handle cases where the error response is not available (e.g., network issues)
//       return ApiErrorResponse(
//         message: [error.message ?? 'Unknown error occurred'],
//         error: 'Network Error',
//         statusCode: error.response?.statusCode ?? 500,
//       );
//     }
//   }
// }

// import 'package:dio/dio.dart';

// class ErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     // Handle Dio errors globally
//     final errorMessage = _handleError(err);

//     // Reject the error with a clear message
//     handler.reject(
//       DioException(
//         requestOptions: err.requestOptions,
//         response: err.response,
//         type: err.type,
//         error:
//             errorMessage, // Instead of passing error object, pass a string message
//         message:
//             errorMessage, // Use the message field to pass the error message
//       ),
//     );
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
// import 'package:tura_app/network/apiErrorResponse.dart';

// class ErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     // Handle Dio errors globally
//     final apiError = _handleError(err);
//     handler.reject(
//       DioException(
//         requestOptions: err.requestOptions,
//         response: err.response,
//         type: err.type,
//         error: apiError,
//         message: apiError.message.join('\n'),
//       ),
//     );
//   }

//   ApiErrorResponse _handleError(DioException error) {
//     // Check if the error has a response and data
//     if (error.response != null && error.response!.data != null) {
//       try {
//         final errorData = error.response!.data;

//         // If errorData is already an instance of ApiErrorResponse, return it directly
//         if (errorData is ApiErrorResponse) {
//           return errorData;
//         }

//         // Otherwise, try to parse it as a Map<String, dynamic>
//         if (errorData is Map<String, dynamic>) {
//           // Handle cases where message can be either a string or a list
//           final message = _normalizeMessage(errorData['message']);
//           return ApiErrorResponse(
//             message: message,
//             error: errorData['error'] ?? 'Unknown Error',
//             statusCode: errorData['statusCode'] ?? 500,
//           );
//         } else {
//           print('Unexpected error response format: $errorData');
//           return ApiErrorResponse(
//             message: _normalizeMessage('Unexpected error format'),
//             error: 'Unexpected Error',
//             statusCode: error.response?.statusCode ?? 500,
//           );
//         }
//       } catch (e) {
//         // If parsing fails, log the error and return a generic error response
//         print('Failed to parse error response: $e');
//         return ApiErrorResponse(
//           message: _normalizeMessage('Failed to parse error response'),
//           error: 'Parsing Error',
//           statusCode: error.response?.statusCode ?? 500,
//         );
//       }
//     } else {
//       // Handle cases where the error response is not available (e.g., network issues)
//       return ApiErrorResponse(
//         message: _normalizeMessage(error.message ?? 'Unknown error occurred'),
//         error: 'Network Error',
//         statusCode: error.response?.statusCode ?? 500,
//       );
//     }
//   }

//   // Normalize the message to always return a List<String>
//   List<String> _normalizeMessage(dynamic message) {
//     if (message is String) {
//       return [message]; // Single message is wrapped in a list
//     } else if (message is List<String>) {
//       return message; // Already a list, so return as-is
//     } else {
//       return ['Unknown error']; // Default case for unexpected formats
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:tura_app/config/network/apiErrorResponse.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle Dio errors globally
    final apiError = _handleError(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: apiError,
        message: apiError.message.join('\n'),
      ),
    );
  }

  ApiErrorResponse _handleError(DioException error) {
    // Check if the error has a response and data
    if (error.response != null && error.response!.data != null) {
      try {
        final errorData = error.response!.data;

        // If errorData is already an instance of ApiErrorResponse, return it directly
        if (errorData is ApiErrorResponse) {
          return errorData;
        }

        // Otherwise, try to parse it as a Map<String, dynamic>
        if (errorData is Map<String, dynamic>) {
          // Handle both cases where 'message' is a List<String> or a String
          final dynamic message = errorData['message'];
          final List<String> messageList = message is List
              ? List<String>.from(message)
              : message is String
                  ? [message]
                  : ['Unknown error occurred'];

          return ApiErrorResponse(
            message: messageList,
            error: errorData['error'] ?? 'Unknown Error',
            statusCode: error.response?.statusCode ?? 500,
          );
        } else {
          print('Unexpected error response format: $errorData');
          return ApiErrorResponse(
            message: ['Unexpected error format'],
            error: 'Unexpected Error',
            statusCode: error.response?.statusCode ?? 500,
          );
        }
      } catch (e) {
        // If parsing fails, log the error and return a generic error response
        print('Failed to parse error response: $e');
        return ApiErrorResponse(
          message: ['Failed to parse error response'],
          error: 'Parsing Error',
          statusCode: error.response?.statusCode ?? 500,
        );
      }
    } else {
      // Handle cases where the error response is not available (e.g., network issues)
      return ApiErrorResponse(
        message: [error.message ?? 'Unknown error occurred'],
        error: 'Network Error',
        statusCode: error.response?.statusCode ?? 500,
      );
    }
  }
}
