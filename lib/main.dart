import 'package:flutter/material.dart';
import 'package:my_finance/screens/splash/splash_screen.dart';
// import 'package:my_finance/screens/login/login_screen.dart';
// import 'package:my_finance/screens/signup/signup_screen.dart';
// import 'package:my_finance/screens/features/dashboard/dashboard_screen.dart';
import 'package:my_finance/utils/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: secondaryColor,
        scaffoldBackgroundColor: secondaryColor,
      ),
      home: const SplashScreen(),
      // home: const LoginScreen(),
      // home: SignupScreen(),
      // home: const DashboardScreen(),
    );
  }
}
