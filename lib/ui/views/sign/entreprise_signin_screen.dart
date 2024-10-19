import 'package:flutter/material.dart';
import 'package:mobile_app/core/viewmodels/componay_view_model.dart';
import 'package:mobile_app/ui/presentation/presentation.dart';
import 'package:mobile_app/ui/views/entreprise/offers_screen.dart';
import 'package:provider/provider.dart';

import 'entreprise_register.dart';

class EntrepriseSignInScreen extends StatefulWidget {
  const EntrepriseSignInScreen({super.key});

  @override
  State<EntrepriseSignInScreen> createState() => _EntrepriseSignInScreenState();
}

class _EntrepriseSignInScreenState extends State<EntrepriseSignInScreen> {
  bool obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    final deviceWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: SingleChildScrollView(
        child: Column(
          children: [
            xxxxlSpacer(),
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(deviceWidth * 0.02),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.3)),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                const Align(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
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
                      'Email',
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Container(
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      fillColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      hintText: 'Enter the Email',
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
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Container(
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: passwordController,
                    obscureText: obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      fillColor: Colors.red,
                      suffixIcon: IconButton(
                        icon: Icon(!obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() {
                          obscureText = !obscureText;
                        }),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      hintText: 'Enter the Password',
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
                  height: deviceHeight * 0.1,
                ),
                Visibility(
                  visible: context.watch<CompanyViewModel>().errorMessage != null,
                  child: Text(
                    context.watch<CompanyViewModel>().errorMessage ?? "",
                    style: const TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                GestureDetector(
                  onTap: () async {
                    await context.read<CompanyViewModel>().login(emailController.text, passwordController.text);
                    if (context.mounted && context.read<CompanyViewModel>().errorMessage == null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OfferScreen(),
                        ),
                      );
                    }
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
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterEntreprise()));
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
    ));
  }
}
