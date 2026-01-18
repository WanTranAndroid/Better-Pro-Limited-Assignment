import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:better_pro_assignment/core/di/injection.dart';
import 'package:better_pro_assignment/features/transaction/presentation/pages/transaction_page.dart';
import 'package:better_pro_assignment/features/transaction/presentation/resolvers/risk_challenge_resolver_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Init Hive
  await Hive.initFlutter();
  
  // 2. Init DI
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Better Pro Assignment',
      navigatorKey: RiskChallengeResolverImpl.navigatorKey, // Important for Risk Dialog
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TransactionPage(),
    );
  }
}
