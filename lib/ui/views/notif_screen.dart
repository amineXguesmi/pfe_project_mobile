import 'package:flutter/material.dart';
import 'package:mobile_app/core/viewmodels/employee_view_model.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:provider/provider.dart';

import '../../core/models/noitifcation.dart';
import '../../core/viewmodels/componay_view_model.dart';
import '../presentation/presentation.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() async {
    if (context.read<EmployeeViewModel>().isEmployeeSignedUp) {
      notifications = await context.read<EmployeeViewModel>().getNotifications();
    } else {
      notifications = await context.read<CompanyViewModel>().getNotifications();
    }

    notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget _appBar() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm, vertical: Dimensions.xxs),
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
                    'Notifications',
                    style: TextStyles.title2Bold(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                xlSpacer(),
                _appBar(),
                SizedBox(
                  height: context.height * 0.82,
                  width: context.width,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 0),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        SizedBox(
                          height: context.height * 0.15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  xsSpacer(),
                                  const CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage('assets/avatar_3.jpg'),
                                  ),
                                  xsSpacer(),
                                  Expanded(
                                    child: Text(
                                      notifications[index].message,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  xxxsSpacer(),
                                  xxxxlSpacer(),
                                  Text(
                                    _formatTimeAgo(notifications[index].createdAt),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          margin: EdgeInsets.symmetric(horizontal: context.width * 0.1),
                          width: context.width,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);
    if (duration.inMinutes < 1) {
      return 'Just now';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes} minutes ago';
    } else if (duration.inHours < 24) {
      return '${duration.inHours} hours ago';
    } else if (duration.inDays == 1) {
      return '1 day ago';
    } else {
      return '${duration.inDays} days ago';
    }
  }
}
