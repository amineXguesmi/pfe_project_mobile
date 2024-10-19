import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:mobile_app/ui/presentation/presentation.dart';
import 'package:mobile_app/ui/views/sign/on_boarding_screen.dart';

import '../../widgets/curve_painter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    final deviceWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.05, vertical: deviceWidth * 0.05),
        child: Column(
          children: [
            xxlSpacer(),
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
              ],
            ),
            mdSpacer(),
            const Text(
              "Forgot password",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            SizedBox(
              height: deviceHeight * 0.01,
            ),
            Text(
              "Recover your account password",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: deviceHeight * 0.06,
            ),
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
              height: deviceHeight * 0.06,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    enableDrag: true,
                    isDismissible: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => DraggableScrollableSheet(
                          builder: (context, scrollController) => CustomPaint(
                            size: Size(context.width, context.height * 0.1),
                            painter: CurvePainter(
                              reversed: true,
                              colors: [
                                Colors.white,
                                Colors.white,
                              ],
                              deviceHeight: context.height,
                              direction: Axis.vertical,
                              curveStrength: 1.5,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.md,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Change Password',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      TextField(
                                        decoration: InputDecoration(
                                          labelText: 'New Password',
                                          hintStyle: TextStyles.body0Semibold(
                                              color: Colors.black),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.sm),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.8)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.sm),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.8)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.sm),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.8)),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: Dimensions.sm,
                                            vertical: Dimensions.xxxs,
                                          ),
                                        ),
                                        style: TextStyles.calloutRegular(
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 20),
                                      TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Confirm New Password',
                                          hintStyle: TextStyles.body0Semibold(
                                              color: Colors.black),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.sm),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.8)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.sm),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.8)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.sm),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.8)),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: Dimensions.sm,
                                            vertical: Dimensions.xxxs,
                                          ),
                                        ),
                                        style: TextStyles.calloutRegular(
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 40),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const OnboardingScreen()),
                                          );
                                        },
                                        child: Container(
                                          height: deviceHeight * 0.06,
                                          width: deviceWidth * 0.5,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF5E569B),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  deviceHeight * 0.1),
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Change Password",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
              },
              child: Container(
                height: deviceHeight * 0.06,
                width: deviceWidth * 0.7,
                decoration: BoxDecoration(
                  color: const Color(0xFF5E569B),
                  borderRadius: BorderRadius.all(
                    Radius.circular(deviceHeight * 0.1),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
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
