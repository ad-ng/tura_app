import 'package:dio/dio.dart';
import 'package:tura_app/network/errorInterceptor.dart';
import 'package:tura_app/network/headerInterceptor.dart';

class DioService {
  // Private constructor for singleton pattern
  DioService._privateConstructor();

  static final DioService instance = DioService._privateConstructor();

  Dio dio = Dio();

  void setup() {
    dio.options.baseUrl = 'https://backend.turaestate.com';

    // Set timeouts
    dio.options.connectTimeout = Duration(seconds: 15);
    dio.options.receiveTimeout = Duration(seconds: 15);

    // Add the custom interceptors to be handled globally
    dio.interceptors.add(ErrorInterceptor());

    dio.interceptors.add(HeaderInterceptor());
  }
}
