import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance/screens/login/bloc/login_bloc.dart';
import 'package:my_finance/screens/login/bloc/login_event.dart';
import 'package:my_finance/screens/login/bloc/login_state.dart';
import 'package:my_finance/screens/signup/signup_screen.dart';
import 'package:my_finance/screens/widgets/bottom_navbar.dart';
// import 'home_screen.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/typography.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: secondaryColor,
          ),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNavbar()),
                  // MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: LoginBody(),
          ),
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  final TextEditingController emailController =
      TextEditingController(text: "Username@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "abcdef123456");

  LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: secondaryColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Text(
            'Sign In',
            style: poppinsH1.copyWith(color: buttonColor, fontSize: 36),
          ),
          Text(
            'Sign in to continue to FinTrack',
            style: poppinsBody1.copyWith(color: textColor),
          ),
          const SizedBox(height: 30),
          _buildTextField(
              "Email Address", emailController, Icons.email_outlined, false),
          const SizedBox(height: 10),
          _buildTextField(
              "Password", passwordController, Icons.lock_outline_rounded, true),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                // return const CircularProgressIndicator();
                return const Center(
                  child: CircularProgressIndicator(
                    color: buttonColor,
                    strokeWidth: 2,
                  ),
                );
              }
              return GestureDetector(
                onTap: () {
                  final email = emailController.text;
                  final password = passwordController.text;

                  context
                      .read<LoginBloc>()
                      .add(LoginSubmitted(email, password));
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  // margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: text2Color,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account? ',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: buttonColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      IconData icon, bool isPassword) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: Color(0xFFAAACAE)),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            obscureText: isPassword,
            cursorColor: textColor,
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w500, color: textColor),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: textColor),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
