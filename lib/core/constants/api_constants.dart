class ApiConstants {
  static const String baseUrl = 'https://api.better.com';
  static const String submitTransaction = '/mock/submit';
  static const String checkStatus = '/mock/status';

  static const String headerOtp = 'X-OTP';
  static const String mockOtpValid = '123456';

  static const int kMaxRetries = 3;
  static const int defaultTimeoutBySecond = 10;
}

class ApiErrorCodes {
  static const String riskChallengeRequired = 'RISK_CHALLENGE_REQUIRED';
  static const String invalidOtp = 'INVALID_OTP';
  static const String timeout = 'TIMEOUT';
}

class MockConfig {
  static const int defaultPrecision = 2;

  static const int minDelayMs = 500;
  static const int maxDelayMs = 1500;

  static const double successRate = 0.6;
  static const double riskRate = 0.2; // 0.6 + 0.2 = 0.8 -> remaining 0.2 is timeout
}
