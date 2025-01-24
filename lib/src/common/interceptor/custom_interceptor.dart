import 'package:dio/dio.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Naver-Client-Id'] = "2SmaacY6kAz4Ti2OUgPa";
    options.headers['X-Naver-Client-Secret'] = "Y7eWnGsjr4";
    super.onRequest(options, handler);
  }
}
