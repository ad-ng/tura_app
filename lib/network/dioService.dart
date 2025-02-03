import 'package:dio/dio.dart';
import 'package:tura_app/network/errorInterceptor.dart';

class DioService {
  // Private constructor for singleton pattern
  DioService._privateConstructor();

  // The single instance of DioService
  static final DioService instance = DioService._privateConstructor();

  // Dio instance
  Dio dio = Dio();

  // Public setup method to configure Dio
  void setup() {
    // Set the base URL for API requests
    dio.options.baseUrl = 'https://backend.turaestate.com';

    // Set timeouts
    dio.options.connectTimeout =
        Duration(seconds: 15); // 15 seconds for connection
    dio.options.receiveTimeout =
        Duration(seconds: 15); // 15 seconds for receiving data

    // Optionally set default headers globally
    dio.options.headers = {
      'Content-Type': 'application/json', // Set default content type
      'Accept': 'application/json',
    };

    // Add the custom error interceptor to handle errors globally
    dio.interceptors
        .add(ErrorInterceptor()); // Add the custom error interceptor
  }
}
