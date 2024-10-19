import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:mobile_app/ui/views/profile/profile_screen.dart';
import 'package:mobile_app/ui/views/sign/on_boarding_screen.dart';
import 'package:mobile_app/ui/widgets/expandable_tile.dart';
import 'package:provider/provider.dart';

import '../../../core/viewmodels/employee_view_model.dart';
import '../../presentation/presentation.dart';
import 'change_password_bottom_sheet.dart';
import 'help_support_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isSwitched = false;

  Widget _appBar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm, vertical: Dimensions.xxs),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: context.width,
              child: Center(
                child: Text(
                  'Settings',
                  style: TextStyles.title2Bold(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _userInfo() => Consumer<EmployeeViewModel>(
        builder: (context, userViewModel, _) {
          if (userViewModel.employee == null) {
            return const SizedBox.shrink();
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lgSpacer(),
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/avatar_3.jpg'),
              ),
              xxsSpacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userViewModel.employee!.name ?? 'John Doe',
                    style: TextStyles.buttonSemibold(),
                  ),
                  Text(
                    userViewModel.employee!.email ?? '@johndoe',
                    style: TextStyles.calloutBold(color: Colors.grey),
                  ),
                ],
              )
            ],
          );
        },
      );

  Widget settingItem({required settingName, required IconData settingIcon, required pressFunction}) => GestureDetector(
        onTap: pressFunction,
        child: ListTile(
          title: Text(settingName, style: TextStyles.buttonMedium()),
          leading: Icon(
            settingIcon,
            color: Colors.black.withOpacity(0.8),
            size: Dimensions.xmd,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: Dimensions.sm,
          ),
        ),
      );

  Widget _personalInfo() => Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Personal Information', style: TextStyles.body0Medium(color: Colors.grey.shade500)),
            settingItem(
                settingName: 'Profile',
                settingIcon: Icons.person_3_outlined,
                pressFunction: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileSettings()));
                }),
            ExpandableTile(
                title: 'Notifications',
                leadingIcon: Icons.notifications_none,
                expandedBody: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(Dimensions.md),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 30),
                          Text('Push Notifications', style: TextStyles.calloutRegular()),
                          const Spacer(),
                          SizedBox(
                            height: 30,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: CupertinoSwitch(
                                value: _isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    _isSwitched = value;
                                  });
                                },
                                activeColor: const Color(0xFF5E569B),
                              ),
                            ),
                          ),
                        ],
                      ),
                      xxxsSpacer(),
                      Row(
                        children: [
                          const SizedBox(width: 30),
                          Text('Push Notifications', style: TextStyles.calloutRegular()),
                          const Spacer(),
                          SizedBox(
                            height: 30,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: CupertinoSwitch(
                                value: _isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    _isSwitched = value;
                                  });
                                },
                                activeColor: const Color(0xFF5E569B),
                              ),
                            ),
                          ),
                        ],
                      ),
                      xxxsSpacer(),
                      Row(
                        children: [
                          const SizedBox(width: 30),
                          Text('Push Notifications', style: TextStyles.calloutRegular()),
                          const Spacer(),
                          SizedBox(
                            height: 30,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: CupertinoSwitch(
                                value: _isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    _isSwitched = value;
                                  });
                                },
                                activeColor: const Color(0xFF5E569B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      );

  Widget _security() => Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Security', style: TextStyles.body0Medium(color: Colors.grey.shade500)),
            settingItem(
                settingName: 'Change Password',
                settingIcon: Icons.lock_outline,
                pressFunction: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    enableDrag: true,
                    isDismissible: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => ChangePasswordBottomSheet(),
                  );
                }),
            ExpandableTile(
              title: 'Security',
              leadingIcon: Icons.security_outlined,
              expandedBody: Container(
                padding: const EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(Dimensions.md),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Face ID', style: TextStyles.calloutRegular()),
                        const Spacer(),
                        SizedBox(
                          height: 30,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: CupertinoSwitch(
                              value: _isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  _isSwitched = value;
                                });
                              },
                              activeColor: const Color(0xFF5E569B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    xxxsSpacer(),
                    Row(
                      children: [
                        Text('Remember Password', style: TextStyles.calloutRegular()),
                        const Spacer(),
                        SizedBox(
                          height: 30,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: CupertinoSwitch(
                              value: _isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  _isSwitched = value;
                                });
                              },
                              activeColor: const Color(0xFF5E569B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    xxxsSpacer(),
                    Row(
                      children: [
                        Text('Touch ID', style: TextStyles.calloutRegular()),
                        const Spacer(),
                        SizedBox(
                          height: 30,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: CupertinoSwitch(
                              value: _isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  _isSwitched = value;
                                });
                              },
                              activeColor: const Color(0xFF5E569B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _about() => Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About', style: TextStyles.body0Medium(color: Colors.grey.shade500)),
            settingItem(
                settingName: 'Legal and Policies',
                settingIcon: Icons.shield_outlined,
                pressFunction: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                            height: context.height * 0.8,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Dimensions.xl),
                                topRight: Radius.circular(Dimensions.xl),
                              ),
                            ),
                            child: Column(
                              children: [
                                lgSpacer(),
                                Text('Legal and Policies', style: TextStyles.title2Bold()),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
                                  child: Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut purus eget nunc. Don egestas, urna nec tincidunt.\n'
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut purus eget nunc. Don egestas, urna nec tincidunt.'
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut purus eget nunc. Don egestas, urna nec tincidunt.\n'
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut purus eget nunc. Don egestas, urna nec tincidunt. ',
                                      style: TextStyles.body0Regular()),
                                ),
                              ],
                            ),
                          ));
                }),
            settingItem(
                settingName: 'Help & Support',
                settingIcon: Icons.help_outline,
                pressFunction: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HelpAndSupportScreen(),
                      ));
                }),
          ],
        ),
      );

  Widget _logoutButton() => GestureDetector(
        onTap: () {
          context.read<EmployeeViewModel>().signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: context.width * 0.1),
          height: context.height * 0.06,
          decoration: BoxDecoration(
            color: const Color(0xFF5E569B),
            borderRadius: BorderRadius.all(
              Radius.circular(context.height * 0.1),
            ),
          ),
          child: const Center(
            child: Text(
              "Log out",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
            ),
          ),
        ),
      );

  Widget _body() => Container(
        color: Colors.white,
        width: context.width,
        height: context.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              xxlSpacer(),
              _appBar(),
              xmdSpacer(),
              _userInfo(),
              xmdSpacer(),
              _personalInfo(),
              xmdSpacer(),
              _security(),
              xmdSpacer(),
              _about(),
              xlgSpacer(),
              _logoutButton(),
              xlgSpacer(),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }
}
