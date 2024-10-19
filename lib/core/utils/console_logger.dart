import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ConsoleLoggerInterceptor extends Interceptor {
  ConsoleLoggerInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (kDebugMode) {
      debugPrint(
        'Request -----------------\n'
        '${options.method}: ${options.uri}\n'
        'HEADERS: ${options.headers}\n'
        'BODY: ${options.data}\n'
        '-------------------------',
      );
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        'Response -----------------\n'
        '${response.statusCode} ${response.requestOptions.method}: '
        '${response.requestOptions.uri}\n'
        'BODY: ${response.data}\n'
        '--------------------------',
      );
    }

    super.onResponse(response, handler);
  }
}
