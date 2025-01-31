import 'package:dio/dio.dart';

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
    dio.options.baseUrl = 'https://backend.kigaluxe.estate/';

    // Set timeouts
    dio.options.connectTimeout =
        Duration(seconds: 15); // 10 seconds for connection
    dio.options.receiveTimeout =
        Duration(seconds: 15); // 10 seconds for receiving data

    // Optionally set default headers globally
    dio.options.headers = {
      'Content-Type': 'application/json', // Set default content type
      'Accept': 'application/json',
    };
  }
}
