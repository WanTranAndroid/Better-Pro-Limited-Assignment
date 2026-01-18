import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:better_pro_assignment/core/core.dart';

@LazySingleton(as: RiskChallengeResolver)
class RiskChallengeResolverImpl implements RiskChallengeResolver {
  // Use a GlobalKey to access Navigator context from anywhere
  // This key must be assigned to MaterialApp.navigatorKey
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<String?> resolveOtp() async {
    // We need to show a dialog on top of the current screen
    final context = navigatorKey.currentContext;
    if (context == null) return null;

    // Show Dialog and wait for result
    return await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String otp = '';
        return AlertDialog(
          title: const Text('Security Verification'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please enter the OTP sent to your device.'),
              const SizedBox(height: 16),
              TextField(
                onChanged: (v) => otp = v,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter OTP (Try ${ApiConstants.mockOtpValid})',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, otp),
              child: const Text('Verify'),
            ),
          ],
        );
      },
    );
  }
}
