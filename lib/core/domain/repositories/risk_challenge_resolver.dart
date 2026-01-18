abstract class RiskChallengeResolver {
  /// Returns the OTP string if successful, or null if cancelled/failed.
  Future<String?> resolveOtp();
}
