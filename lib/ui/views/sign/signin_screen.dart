import 'package:flutter/material.dart';
import 'package:mobile_app/ui/presentation/presentation.dart';
import 'package:mobile_app/ui/views/home_tab.dart';
import 'package:mobile_app/ui/views/sign/on_boarding_screen.dart';
import 'package:mobile_app/ui/views/sign/signup_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/viewmodels/employee_view_model.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    final deviceWidth = MediaQuery.sizeOf(context).width;

    return PopScope(
      canPop: false,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
          child: Column(
            children: [
              xxxxlSpacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(deviceWidth * 0.02),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.3)),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox.shrink()
                ],
              ),
              xxlSpacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email Address',
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  SizedBox(height: deviceHeight * 0.01),
                  Container(
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email address',
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(height: deviceHeight * 0.02),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  SizedBox(height: deviceHeight * 0.01),
                  Container(
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
                        suffixIcon: IconButton(
                          icon: Icon(!obscureText ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() {
                            obscureText = !obscureText;
                          }),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(height: deviceHeight * 0.02),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                        );
                      },
                      child: const Text(
                        'forgot password',
                        style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  xxxlSpacer(),
                  Visibility(
                    visible: context.watch<EmployeeViewModel>().loginError.isNotEmpty,
                    child: Text(
                      context.watch<EmployeeViewModel>().loginError,
                      style: const TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  smSpacer(),
                  GestureDetector(
                    onTap: () async {
                      String email = _emailController.text.trim();
                      String password = _passwordController.text.trim();
                      final result = await context.read<EmployeeViewModel>().signIn(email, password);

                      if (context.mounted && result) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeTab()));
                      }
                    },
                    child: Container(
                      height: deviceHeight * 0.06,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5E569B),
                        borderRadius: BorderRadius.circular(deviceHeight * 0.1),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(deviceHeight * 0.02)),
                        width: deviceWidth * 0.15,
                        height: deviceHeight * 0.002,
                      ),
                      SizedBox(
                        width: deviceWidth * 0.05,
                      ),
                      Text(
                        'Or continue with',
                        style:
                            TextStyle(color: Colors.black.withOpacity(0.4), fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        width: deviceWidth * 0.05,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(deviceHeight * 0.02)),
                        width: deviceWidth * 0.15,
                        height: deviceHeight * 0.002,
                      )
                    ],
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // final  user = await signInWithGoogle();
                      // if (user != null) {
                      //   // Navigate to another screen or do something else with the user details
                      // } else {
                      //   // Handle error or display a message
                      // }
                    },
                    child: Container(
                      height: deviceHeight * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(deviceHeight * 0.1),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Continue with Google",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Color(0xFF5E569B), fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
