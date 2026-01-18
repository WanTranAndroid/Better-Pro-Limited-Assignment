import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:better_pro_assignment/core/core.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(
    RetryInterceptor retryInterceptor,
    AuthInterceptor authInterceptor,
    RiskInterceptor riskInterceptor,
    MockServerInterceptor mockServerInterceptor,
  ) {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: ApiConstants.defaultTimeoutBySecond),
      receiveTimeout: const Duration(seconds: ApiConstants.defaultTimeoutBySecond),
      sendTimeout: const Duration(seconds: ApiConstants.defaultTimeoutBySecond),
    ));

    // Circular Dependency Break: Set Dio instance manually
    retryInterceptor.setDio(dio);
    riskInterceptor.setDio(dio);

    // Order matters!
    // 1. Retry (Outer most) - catches errors from inner interceptors
    // 2. Auth - handles token refresh
    // 3. Risk - handles 403
    // 4. Mock - simulates server response
    dio.interceptors.addAll([
      retryInterceptor,
      authInterceptor,
      riskInterceptor,
      mockServerInterceptor,
      LogInterceptor(requestBody: true, responseBody: true),
    ]);

    return dio;
  }
}
