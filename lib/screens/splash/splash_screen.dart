import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance/screens/splash/bloc/splash_bloc.dart';
import 'package:my_finance/screens/splash/bloc/splash_event.dart';
import 'package:my_finance/screens/splash/bloc/splash_state.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/screens/login/login_screen.dart';
// import 'package:my_finance/screens/features/dashboard/dashboard_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigate) {
            Navigator.pushReplacement(
              context,
              // MaterialPageRoute(builder: (context) => const DashboardScreen()),
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        },
        child: Scaffold(
          // backgroundColor: Colors.white,
          body: Stack(
            children: [
              // Background gradient
              Container(
                decoration: const BoxDecoration(
                  color: secondaryColor,
                ),
              ),
              // Content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.account_balance_wallet_rounded,
                          size: 120,
                          color: buttonColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Title
                    const Text(
                      "FinTrack",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Subtitle
                    const Text(
                      "My Finance Tracking App",
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // Loading Indicator
              const Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
