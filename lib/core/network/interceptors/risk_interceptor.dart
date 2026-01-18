import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:better_pro_assignment/core/domain/repositories/risk_challenge_resolver.dart';
import 'package:better_pro_assignment/core/constants/api_constants.dart';

@injectable
class RiskInterceptor extends QueuedInterceptor {
  final RiskChallengeResolver _resolver;
  late final Dio _dio;

  RiskInterceptor(this._resolver);

  void setDio(Dio dio) {
    _dio = dio;
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if we have already tried to resolve the risk for this request
    final isRiskRetried = err.requestOptions.extra['is_risk_retry'] == true;

    // 1. Check for 403 Risk Challenge AND ensure we haven't retried yet
    if (err.response?.statusCode == 403 && !isRiskRetried) {
      try {
        // 2. Trigger Challenge (UI Dialog)
        final otp = await _resolver.resolveOtp();

        if (otp != null) {
          // 3. Retry with OTP
          final options = err.requestOptions;
          options.headers[ApiConstants.headerOtp] = otp; // Attach OTP
          
          // Mark this request as retried for risk challenge to avoid infinite loop when wrong OTP
          options.extra['is_risk_retry'] = true; 
          
          // Clone request to ensure fresh execution
          final response = await _dio.fetch(options);
          
          // 4. Resolve the original request with the new response
          return handler.resolve(response);
        } else {
          // User cancelled the dialog -> Fail the request
          return handler.next(err);
        }
      } catch (e) {
        // If the retry fails (e.g. OTP wrong -> 403 again, or 400),
        // because is_risk_retry is now true, the next loop (if any) will skip this block
        // and fall through to handler.next(e) below (or inside the catch if we rethrow).
        
        // If _dio.fetch throws, it comes here. 
        // We should pass the NEW error down, not the old 'err'.
        if (e is DioException) {
           return handler.next(e);
        }
        return handler.next(err);
      }
    }

    // Pass through other errors (or if 403 happens again after retry)
    super.onError(err, handler);
  }
}
