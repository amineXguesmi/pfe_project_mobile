import 'package:flutter/material.dart';
import 'package:mobile_app/ui/presentation/presentation.dart';
import 'package:mobile_app/ui/views/home_tab.dart';
import 'package:mobile_app/ui/views/sign/forgot_password_screen.dart';
import 'package:mobile_app/ui/views/sign/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    final deviceWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: Column(
        children: [
          xxxxlSpacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(deviceWidth * 0.02),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.3)),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              SizedBox(
                width: deviceWidth * 0.26,
              ),
              const Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
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
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.red,
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                    ),
                    hintText: 'Enter your email address',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.4),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  obscureText: obscureText,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    fillColor: Colors.red,
                    suffixIcon: IconButton(
                      icon: Icon(!obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => setState(() {
                        obscureText = !obscureText;
                      }),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                    ),
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.4),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen()),
                    );
                  },
                  child: const Text(
                    'forgot password',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeTab()),
                  );
                },
                child: Container(
                  height: deviceHeight * 0.06,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5E569B),
                    borderRadius: BorderRadius.all(
                      Radius.circular(deviceHeight * 0.1),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
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
                        borderRadius:
                            BorderRadius.circular(deviceHeight * 0.02)),
                    width: deviceWidth * 0.15,
                    height: deviceHeight * 0.002,
                  ),
                  SizedBox(
                    width: deviceWidth * 0.05,
                  ),
                  Text(
                    'Or continue with',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.05,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius:
                            BorderRadius.circular(deviceHeight * 0.02)),
                    width: deviceWidth * 0.15,
                    height: deviceHeight * 0.002,
                  )
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.05,
              ),
              GestureDetector(
                onTap: () {},
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
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
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
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          color: Color(0xFF5E569B),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    ));
  }
}
