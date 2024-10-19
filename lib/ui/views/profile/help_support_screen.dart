import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';

import '../../presentation/presentation.dart';
import '../../widgets/expandable_tile.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  Widget _appBar() => Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.sm, vertical: Dimensions.xxs),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                iconSize: Dimensions.xmd,
              ),
            ),
            SizedBox(
              width: context.width,
              child: Center(
                child: Text(
                  'Help and Support',
                  style: TextStyles.title2Bold(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        xxlSpacer(),
        _appBar(),
        xlgSpacer(),
        SizedBox(
          height: context.height * 0.7,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
              child: Column(
                children: [
                  ExpandableTile(
                    title: 'How to create an account?',
                    expandedBody: Text(
                      'To create an account, click on the sign-up button and fill in the required details.',
                      style: TextStyles.calloutRegular(),
                    ),
                  ),
                  mdSpacer(),
                  ExpandableTile(
                    title: 'How to reset password?',
                    expandedBody: Text(
                      'To reset your password, click on the forgot password button and follow the instructions.',
                      style: TextStyles.calloutRegular(),
                    ),
                  ),
                  mdSpacer(),
                  ExpandableTile(
                    title: 'How to delete account?',
                    expandedBody: Text(
                      'To delete your account, click on the delete account button and follow the instructions.',
                      style: TextStyles.calloutRegular(),
                    ),
                  ),
                  mdSpacer(),
                  ExpandableTile(
                    title: 'How to contact support?',
                    expandedBody: Text(
                      'To contact support, click on the contact support button and follow the instructions.',
                      style: TextStyles.calloutRegular(),
                    ),
                  ),
                  mdSpacer(),
                  ExpandableTile(
                    title: 'How to report a bug?',
                    expandedBody: Text(
                      'To report a bug, click on the report bug button and follow the instructions.',
                      style: TextStyles.calloutRegular(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
