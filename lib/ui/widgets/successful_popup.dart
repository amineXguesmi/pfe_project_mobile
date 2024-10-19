import 'package:flutter/material.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:mobile_app/ui/presentation/presentation.dart';

import '../views/sign/signin_screen.dart';

class SuccessfulPopup extends StatelessWidget {
  const SuccessfulPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
              'You have logged in succesfully',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            xsSpacer(),
            const Text(
              'Lorem ipsum is simply dummy text of the printing and typesetting industry',
              textAlign: TextAlign.center,
            ),
            xsSpacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
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
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
