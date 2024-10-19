import 'package:flutter/material.dart';
import 'package:mobile_app/ui/presentation/presentation.dart';
import 'package:mobile_app/ui/views/sign/entreprise_signin_screen.dart';
import 'package:mobile_app/ui/views/sign/signin_screen.dart';
import 'package:mobile_app/ui/views/sign/signup_screen.dart';

import '../entreprise/offers_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height; //size tel responsive
    final deviceWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: deviceHeight,
          width: deviceWidth,
          color: const Color(0xFF5E569B),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset("assets/app_logo.jpeg"),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(deviceWidth * 0.1),
            width: deviceWidth,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                topLeft: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Discover job",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                const Text(
                  "Opportunites Effotlessly!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                const Text(
                  "welcome to our app in which you can sing as en employee or as a society",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                mdSpacer(),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EntrepriseSignInScreen()),
                        );
                      },
                      child: Container(
                        padding: Paddings.allSm,
                        decoration: BoxDecoration(
                          color: const Color(0xFF5E569B),
                          borderRadius: BorderRadius.all(
                            Radius.circular(deviceHeight * 0.1),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Sign As an Entreprise",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    xxxsSpacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInScreen()),
                        );
                      },
                      child: Container(
                        padding: Paddings.allSm,
                        decoration: BoxDecoration(
                            color: const Color(0xFF5E569B),
                            borderRadius: BorderRadius.all(Radius.circular(deviceHeight * 0.1))),
                        child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Sign As an Employee",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                            )),
                      ),
                    ),
                  ],
                ),
                xsSpacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
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
          ),
        )
      ],
    ));
  }
}
