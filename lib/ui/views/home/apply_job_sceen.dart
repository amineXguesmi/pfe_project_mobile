import 'package:flutter/material.dart';
import 'package:mobile_app/core/viewmodels/employee_view_model.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:mobile_app/ui/widgets/upload_cv_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/models/offer.dart';
import '../../presentation/presentation.dart';
import '../home_tab.dart';

class ApplyJobScreen extends StatefulWidget {
  const ApplyJobScreen({super.key, required this.offer});

  final Offer offer;

  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  bool showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            xxxxlSpacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(context.width * 0.02),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.3)),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: context.width * 0.25,
                ),
                const Text(
                  'Job Detail',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            xxlSpacer(),
            AnimatedCrossFade(
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Biodata',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  xxxsSpacer(),
                  Text(
                    'The contents of your biodata are as complete as possible to make it easier for companies to get to know you',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  mdSpacer(),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your Fullname',
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                        hintText: 'Enter your name Ex: Siwar Nafti',
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
                    height: context.height * 0.02,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email Address',
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                        hintText: 'Enter your email address Ex: siwar.nafti@gmail.com',
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
                    height: context.height * 0.02,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Phone',
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                        hintText: 'Enter your phone number',
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
                    height: context.height * 0.02,
                  ),
                ],
              ),
              secondChild: const UploadCv(),
              crossFadeState: showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 600),
            ),
            GestureDetector(
              onTap: () {
                if (showFirst) {
                  setState(() {
                    showFirst = false;
                  });
                } else {
                  if (context.read<EmployeeViewModel>().selectedCv != null) {
                    context.read<EmployeeViewModel>().applyToOffer(int.parse(widget.offer.id));
                  }
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeTab(
                                initialIndex: 0,
                              )));
                }
              },
              child: Container(
                margin: EdgeInsets.all(context.height * 0.07),
                width: context.width,
                height: context.height * 0.06,
                decoration: BoxDecoration(
                  color: const Color(0xFF5E569B),
                  borderRadius: BorderRadius.circular(Dimensions.sm),
                ),
                child: Center(
                  child: Text(
                    'next',
                    style: TextStyles.buttonMedium(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
