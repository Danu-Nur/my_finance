import 'package:flutter/material.dart';
// import 'package:my_finance/screens/splash/splash_screen.dart';
// import 'package:my_finance/screens/login/login_screen.dart';
// import 'package:my_finance/screens/signup/signup_screen.dart';
// import 'package:my_finance/screens/features/dashboard/dashboard_screen.dart';
import 'package:my_finance/screens/widgets/bottom_navbar.dart';
import 'package:my_finance/utils/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    runApp(const MyApp());
  } catch (e) {
    runApp(ErrorApp(e.toString()));
  }
}


class ErrorApp extends StatelessWidget {
  final String errorMessage;
  const ErrorApp(this.errorMessage, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Error initializing Firebase: $errorMessage'),
        ),
      ),
    );
  }
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
      // home: const SplashScreen(),
      // home: const LoginScreen(),
      // home: SignupScreen(),
      home: const BottomNavbar(),
    );
  }
}
