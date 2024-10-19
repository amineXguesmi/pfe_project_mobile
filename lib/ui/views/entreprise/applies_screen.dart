import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:mobile_app/core/models/cv.dart';
import 'package:mobile_app/core/viewmodels/componay_view_model.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:provider/provider.dart';

import '../../presentation/presentation.dart';

class AppliesScreen extends StatefulWidget {
  final int offerId;

  const AppliesScreen({super.key, required this.offerId});

  @override
  State<AppliesScreen> createState() => _AppliesScreenState();
}

class _AppliesScreenState extends State<AppliesScreen> {
  List<CV> cvs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCvs();
  }

  Future<void> _loadCvs() async {
    final result = await context.read<CompanyViewModel>().getCvsFromOffer(widget.offerId);
    setState(() {
      cvs = result;
      isLoading = false;
    });
  }

  // Function to fetch PDF file from the server
  Future<String> fetchPdfFile(String cvUrl) async {
    try {
      final response = await Dio().get(
        cvUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      final file = File('/storage/emulated/0/Download/temp_cv.pdf');
      await file.writeAsBytes(response.data);
      return file.path;
    } on DioException catch (e) {
      print('Error fetching PDF: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          xxlSpacer(),
          _appBar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.width * 0.049,
              ),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : cvs.isEmpty
                      ? Center(
                          child: Text(
                          'No one applied yet to this offer',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                          ),
                        ))
                      : ListView.builder(
                          itemCount: cvs.length,
                          itemBuilder: (context, index) {
                            final cv = cvs[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(Dimensions.md),
                                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10.0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: context.height * 0.02,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: context.width * 0.1,
                                        backgroundImage: const AssetImage('assets/avatar_3.jpg'),
                                      ),
                                      xsSpacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cv.employee?.name ?? 'No Name',
                                            style: TextStyles.body1Medium(),
                                          ),
                                          Text(
                                            cv.employee?.surname ?? 'No Surname',
                                            style: TextStyles.body0Semibold(color: Colors.grey.withOpacity(0.8)),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Cv Title :',
                                            style: TextStyles.body0Semibold(color: Colors.black),
                                          ),
                                          Text(
                                            cv.title,
                                            style: TextStyles.body0Semibold(color: Colors.grey.withOpacity(0.8)),
                                          ),
                                        ],
                                      ),
                                      xxxsSpacer(),
                                    ],
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.width * 0.05,
                                      vertical: context.height * 0.02,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Education: ",
                                              style: TextStyles.body0Bold(color: Colors.black),
                                            ),
                                            Text(
                                              cv.education,
                                              style: TextStyles.body0Regular(color: Colors.grey.withOpacity(0.8)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Experience: ",
                                              style: TextStyles.body0Bold(color: Colors.black),
                                            ),
                                            Text(
                                              cv.experience,
                                              style: TextStyles.body0Regular(color: Colors.grey.withOpacity(0.8)),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              String pdfUrl = 'http://192.168.56.1:3000/getResumes/${cv.file}';
                                              String pdfFilePath = await fetchPdfFile(pdfUrl);

                                              if (context.mounted && pdfFilePath.isNotEmpty) {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      content: SizedBox(
                                                        width: double.maxFinite,
                                                        height: 400,
                                                        child: PDFView(
                                                          filePath: pdfFilePath,
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: const Text('Close'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            child: const Text('View CV'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.width * 0.05,
                                      vertical: context.height * 0.02,
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Status',
                                              style: TextStyles.body0Bold(color: Colors.black),
                                            ),
                                            Text(
                                              cv.status,
                                              style: TextStyles.body0Regular(color: Colors.grey.withOpacity(0.8)),
                                            ),
                                          ],
                                        ),
                                        if (cv.status == 'pending') ...[
                                          const Spacer(),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  final result = await context
                                                      .read<CompanyViewModel>()
                                                      .respondToCv(cv.id, 'accepted');
                                                  if (result) {
                                                    _loadCvs();
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.purple,
                                                    borderRadius: BorderRadius.circular(Dimensions.sm),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: Dimensions.xs,
                                                    vertical: context.height * 0.01,
                                                  ),
                                                  child: Text(
                                                    'Accept',
                                                    style: TextStyles.body0Regular(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              xxxsSpacer(),
                                              GestureDetector(
                                                onTap: () async {
                                                  final result = await context
                                                      .read<CompanyViewModel>()
                                                      .respondToCv(cv.id, 'rejected');
                                                  if (result) {
                                                    _loadCvs();
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.circular(Dimensions.sm),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: Dimensions.xs,
                                                    vertical: context.height * 0.01,
                                                  ),
                                                  child: Text(
                                                    'Decline',
                                                    style: TextStyles.body0Regular(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }

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
                  'Applied Candidates',
                  style: TextStyles.title2Bold(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
}
