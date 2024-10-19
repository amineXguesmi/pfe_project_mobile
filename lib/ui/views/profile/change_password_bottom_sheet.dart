import 'package:flutter/material.dart';
import 'package:mobile_app/core/viewmodels/employee_view_model.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:provider/provider.dart';

import '../../presentation/presentation.dart';
import '../../widgets/curve_painter.dart';

class ChangePasswordBottomSheet extends StatelessWidget {
  ChangePasswordBottomSheet({super.key});

  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
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
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      hintStyle: TextStyles.body0Semibold(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.sm),
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.sm),
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.sm),
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.sm,
                        vertical: Dimensions.xxxs,
                      ),
                    ),
                    style: TextStyles.calloutRegular(color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: confirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm New Password',
                      hintStyle: TextStyles.body0Semibold(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.sm),
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.sm),
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.sm),
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.sm,
                        vertical: Dimensions.xxxs,
                      ),
                    ),
                    style: TextStyles.calloutRegular(color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (password.text != confirmPassword.text) {
                        return;
                      }
                      final result =
                          await Provider.of<EmployeeViewModel>(context, listen: false).updatePassword(password.text);

                      if (context.mounted && result) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Password Updated Successfully'),
                          duration: Duration(seconds: 2),
                        ));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Failed to update password'),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                    child: const Text('Change Password'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
