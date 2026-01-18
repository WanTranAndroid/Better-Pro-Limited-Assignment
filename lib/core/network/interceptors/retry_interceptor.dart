import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:better_pro_assignment/core/core.dart';

@injectable
class RetryInterceptor extends Interceptor {
  late final Dio _dio;

  void setDio(Dio dio) {
    _dio = dio;
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final extra = err.requestOptions.extra;
    final retryCount = (extra['retry_count'] as int?) ?? 0;

    if (_shouldRetry(err) && retryCount < ApiConstants.kMaxRetries) {
      try {
        final options = err.requestOptions;
        options.extra['retry_count'] = retryCount + 1;
        
        // Simple linear backoff: 1s, 2s, 3s
        final delay = Duration(seconds: retryCount + 1);
        await Future.delayed(delay);
        
        final response = await _dio.fetch(options);
        return handler.resolve(response);
      } catch (e) {
        // If retry throws an exception (which is likely another DioException),
        // it will be caught by the next onError call or bubble up.
        // However, since we are inside onError, we should be careful not to infinite loop
        // if the logic wasn't guarded by retryCount.
        
        // In this block, 'e' is typically the result of _dio.fetch throwing.
        // We let it propagate naturally, or we can handle it.
        // But to be safe and compatible with Dio flow:
        if (e is DioException) {
           return handler.next(e);
        }
      }
    }
    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           err.type == DioExceptionType.sendTimeout ||
           (err.error is SocketException) ||
           (err.response?.statusCode == 504); 
  }
}
