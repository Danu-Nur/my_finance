import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_finance/screens/signup/bloc/signup_bloc.dart';
import 'package:my_finance/screens/signup/bloc/signup_event.dart';
import 'package:my_finance/screens/signup/bloc/signup_state.dart';
import 'package:my_finance/screens/login/login_screen.dart';
import 'package:my_finance/utils/color.dart';
import 'package:my_finance/utils/typography.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: secondaryColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocListener<SignupBloc, SignupState>(
            listener: (context, state) {
              if (state is SignupSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sign Up Successful!')),
                );
                Navigator.pop(context);
              } else if (state is SignupError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text(
                  'Sign Up',
                  style: poppinsH1.copyWith(color: buttonColor, fontSize: 36),
                ),
                Text(
                  'Join us to continue to FinTrack',
                  style: poppinsBody1.copyWith(color: textColor),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle:
                        poppinsBody1.copyWith(color: textColor.withOpacity(.5)),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  style: poppinsBody1.copyWith(color: textColor),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    hintStyle:
                        poppinsBody1.copyWith(color: textColor.withOpacity(.5)),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  style: poppinsBody1.copyWith(color: textColor),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle:
                        poppinsBody1.copyWith(color: textColor.withOpacity(.5)),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  obscureText: true,
                  style: poppinsBody1.copyWith(color: textColor),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Confirmation Password',
                    hintStyle:
                        poppinsBody1.copyWith(color: textColor.withOpacity(.5)),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  obscureText: true,
                  style: poppinsBody1.copyWith(color: textColor),
                ),
                const SizedBox(height: 20),
                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    if (state is SignupLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: buttonColor,
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        final fullName = fullNameController.text;
                        final email = emailController.text;
                        final password = passwordController.text;

                        context
                            .read<SignupBloc>()
                            .add(SubmitSignup(fullName, email, password));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: poppinsH4.copyWith(color: text2Color),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Have an account? ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: buttonColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
