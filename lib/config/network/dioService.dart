import 'package:dio/dio.dart';
import 'package:tura_app/config/network/errorInterceptor.dart';
import 'package:tura_app/config/network/headerInterceptor.dart';

class DioService {
  // Private constructor for singleton pattern
  DioService._privateConstructor();

  static final DioService instance = DioService._privateConstructor();

  Dio dio = Dio();

  void setup() {
    dio.options.baseUrl =
        'http://backend.turaestates.com'; //'https://backend.turaestate.com';

    // Set timeouts
    dio.options.connectTimeout = Duration(seconds: 15);
    dio.options.receiveTimeout = Duration(seconds: 15);

    dio.options.headers = {
      'Content-Type': 'application/json', // Set default content type
      'Accept': 'application/json',
    };

    // Add the custom interceptors to be handled globally
    dio.interceptors.add(ErrorInterceptor());

    dio.interceptors.add(HeaderInterceptor());
  }
}
