import 'package:dio/dio.dart';
import 'package:tura_app/features/login/data/datasources/local/tokenStore.dart';

class HeaderInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await Tokenstore.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    //options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }
}
