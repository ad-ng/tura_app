import 'package:dio/dio.dart';
import 'package:tura_app/config/network/apiErrorResponse.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Debug: Print the request options to verify the flag
    print('Request Path: ${err.requestOptions.path}');
    print('Request Extra: ${err.requestOptions.extra}');

    // Check if the interceptor should be skipped for this request
    final useErrorInterceptor =
        err.requestOptions.extra['useErrorInterceptor'] ?? true;
    print('useErrorInterceptor: $useErrorInterceptor');

    if (!useErrorInterceptor) {
      print('ErrorInterceptor: Skipping error handling for this request');
      handler.next(err); // Pass the error to the next handler
      return;
    }

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
