import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:mobile_app/ui/presentation/extensions/media_query.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/employee_view_model.dart';

class UploadCv extends StatefulWidget {
  const UploadCv({super.key});

  @override
  State<UploadCv> createState() => _UploadCvState();
}

class _UploadCvState extends State<UploadCv> {
  String? _filePath;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
              );
              if (result != null && result.files.single.path != null) {
                setState(() {
                  _filePath = result.files.single.path;
                  context.read<EmployeeViewModel>().setSelectedCv = File(_filePath!);
                });
              }
            },
            child: const Text('Select PDF'),
          ),
          const SizedBox(height: 20),
          _filePath != null
              ? SizedBox(
                  height: context.height * 0.5, // Adjust height as needed
                  child: PDFView(
                    filePath: _filePath!,
                  ),
                )
              : const Center(
                  child: Text('No PDF selected'),
                ),
        ],
      ),
    );
  }
}
