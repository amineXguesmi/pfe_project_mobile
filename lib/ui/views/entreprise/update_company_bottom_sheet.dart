import 'package:flutter/material.dart';
import 'package:mobile_app/core/viewmodels/componay_view_model.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:provider/provider.dart';

import '../../presentation/presentation.dart';
import '../../widgets/curve_painter.dart';

class UpdateCompanyBottomSheet extends StatelessWidget {
  UpdateCompanyBottomSheet({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > MediaQuery.of(context).viewPadding.bottom;
    return DraggableScrollableSheet(
      minChildSize: isKeyboardOpen ? 0.8 : 0.25,
      initialChildSize: isKeyboardOpen ? 0.8 : 0.5,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              xxxlSpacer(),
              _field(label: 'Password', controller: passwordController),
              xsSpacer(),
              _field(label: 'confirm Your password', controller: confirmPasswordController),
              xmdSpacer(),
              _saveButton(context),
              xlgSpacer(),
              SizedBox(height: isKeyboardOpen ? context.height * 0.3 : 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field({required String label, required TextEditingController controller}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyles.body0Regular(color: Colors.grey.shade500)),
            xxxsSpacer(),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: label,
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
          ],
        ),
      );

  Widget _saveButton(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.xxxs),
        width: context.width * 0.6,
        decoration: BoxDecoration(
          color: const Color(0xFF5E569B),
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(Dimensions.md),
        ),
        child: TextButton(
          onPressed: () async {
            if (passwordController.text.isEmpty && confirmPasswordController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Nothing To change'),
                duration: Duration(seconds: 2),
              ));
              return;
            } else if (passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please Complete both forms'),
                duration: Duration(seconds: 2),
              ));
              return;
            } else if (passwordController.text != confirmPasswordController.text) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Password doesn't match"),
                duration: Duration(seconds: 2),
              ));
              return;
            }
            final result = await context.read<CompanyViewModel>().updatePassword(
                  context.read<CompanyViewModel>().company!.id!,
                  passwordController.text,
                );

            if (result) {
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
          child: Center(child: Text("Change Password", style: TextStyles.buttonRegular(color: Colors.white))),
        ),
      );
}
