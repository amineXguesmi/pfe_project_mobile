import 'package:dio/dio.dart';

class ResponseStatusInterceptor extends Interceptor {
  ResponseStatusInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    }
    super.onResponse(response, handler);
  }
}
