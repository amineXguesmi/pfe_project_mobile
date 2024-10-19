import 'package:flutter/material.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:provider/provider.dart';

import '../../../core/viewmodels/componay_view_model.dart';
import '../../presentation/presentation.dart';
import 'entreprise_signin_screen.dart';

class RegisterEntreprise extends StatefulWidget {
  const RegisterEntreprise({super.key});

  @override
  State<RegisterEntreprise> createState() => _RegisterEntrepriseState();
}

class _RegisterEntrepriseState extends State<RegisterEntreprise> {
  TextEditingController companyName = TextEditingController();
  TextEditingController mf = TextEditingController();
  TextEditingController email = TextEditingController();

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
                    'Sign Up Your Company',
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
                      'Company Name',
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
                    )),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Container(
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: companyName,
                    decoration: InputDecoration(
                      fillColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      hintText: 'Enter Your Company Name',
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
                    'Tax Number',
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
                    controller: mf,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      fillColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      hintText: 'Enter the company tax number',
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
                    'Email',
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
                    controller: email,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      fillColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      hintText: 'Enter Your Email',
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
                Visibility(
                  visible: context.watch<CompanyViewModel>().errorSignUpMessage != null,
                  child: Text(
                    context.watch<CompanyViewModel>().errorSignUpMessage ?? "",
                    style: const TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                GestureDetector(
                  onTap: () async {
                    await context.read<CompanyViewModel>().checkCompany(companyName.text, mf.text, email.text);

                    if (context.mounted && context.read<CompanyViewModel>().errorSignUpMessage == null) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Container(
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                            height: context.height * 0.09,
                            child: Icon(
                              Icons.check_outlined,
                              color: Colors.white,
                              size: context.height * 0.06,
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                xxxsSpacer(),
                                const Text(
                                  'You Company checked successfully',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                xsSpacer(),
                                const Text(
                                  'Check your email for Your Password',
                                  textAlign: TextAlign.center,
                                ),
                                xsSpacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) => const EntrepriseSignInScreen()));
                                  },
                                  child: Container(
                                    height: context.height * 0.06,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF5E569B),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(context.height * 0.1),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Continue",
                                        style:
                                            TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EntrepriseSignInScreen(),
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
                        "Sign Up",
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
                      "Already have an account?",
                      style: TextStyle(color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EntrepriseSignInScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        " Sign In",
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
