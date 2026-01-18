import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add Bearer token if available
    // options.headers['Authorization'] = 'Bearer ...';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // 1. Lock Request Queue
      // 2. Refresh Token
      // 3. Unlock & Retry
      // Placeholder in real business
    }
    super.onError(err, handler);
  }
}
