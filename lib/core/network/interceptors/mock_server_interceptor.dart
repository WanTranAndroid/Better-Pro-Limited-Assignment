import 'dart:math';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:better_pro_assignment/core/core.dart';

@injectable
class MockServerInterceptor extends Interceptor {
  final Random _random = Random();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Only mock specific paths
    if (!options.path.startsWith('/mock')) {
      return super.onRequest(options, handler);
    }

    // Simulate network latency
    final delay = MockConfig.minDelayMs + _random.nextInt(MockConfig.maxDelayMs - MockConfig.minDelayMs);
    await Future.delayed(Duration(milliseconds: delay));

    if (options.path.contains(ApiConstants.submitTransaction)) {
      _handleSubmit(options, handler);
    } else if (options.path.contains(ApiConstants.checkStatus)) {
      _handleStatus(options, handler);
    } else {
      // 404
      handler.reject(DioException(
        requestOptions: options,
        response: Response(
          requestOptions: options,
          statusCode: 404,
        ),
        type: DioExceptionType.badResponse,
      ));
    }
  }

  void _handleSubmit(RequestOptions options, RequestInterceptorHandler handler) {

    // 1. Check if OTP is provided (Recovery from Risk)
    if (options.headers.containsKey(ApiConstants.headerOtp)) {
      final otp = options.headers[ApiConstants.headerOtp];

      if (otp == ApiConstants.mockOtpValid) { 
         return handler.resolve(Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            ...options.data,
            'status': 'completed',
            'id': options.data['id'],
            'timestamp': DateTime.now().millisecondsSinceEpoch,
          },
        ));
      } else {
         return handler.reject(DioException(
          requestOptions: options,
          response: Response(
            requestOptions: options,
            statusCode: 400,
            data: {'code': ApiErrorCodes.invalidOtp},
          ),
          type: DioExceptionType.badResponse,
        ));
      }
    }

    // 2. Random Outcome
    final r = _random.nextDouble();

    if (r < MockConfig.successRate) {
      handler.resolve(Response(
        requestOptions: options,
        statusCode: 200,
        // Mock server, not use enum in domain
        data: {
          ...options.data,
          'status': 'completed',
          'id': options.data['id'],
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      ));
    } else if (r < (MockConfig.successRate + MockConfig.riskRate)) {
      handler.reject(DioException(
        requestOptions: options,
        response: Response(
          requestOptions: options,
          statusCode: 403,
          data: {'code': ApiErrorCodes.riskChallengeRequired},
        ),
        type: DioExceptionType.badResponse,
      ), true);
    } else {
      handler.reject(DioException(
        requestOptions: options,
        response: Response(
          requestOptions: options,
          statusCode: 504,
          data: {'code': ApiErrorCodes.timeout},
        ),
        type: DioExceptionType.badResponse,
      ), true);
    }
  }

  void _handleStatus(RequestOptions options, RequestInterceptorHandler handler) {
    // Random status for better testing
    // Mock server, not use enum in domain
    final statuses = ['completed', 'failed', 'pending'];
    final status = statuses[_random.nextInt(statuses.length)];

    handler.resolve(Response(
      requestOptions: options,
      statusCode: 200,
      data: {
        'id': options.queryParameters['id'],
        'status': status,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'amountValue': '0',
        'amountPrecision': 0,
        'currency': 'USD',
      },
    ));
  }
}
