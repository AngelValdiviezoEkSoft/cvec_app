import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file/open_file.dart';

class FileViewer extends StatelessWidget {
  final File file;

  const FileViewer({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final String extension = file.path.split('.').last.toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension)) {
      // Mostrar imagen
      return Image.file(file, fit: BoxFit.contain);
    } else if (extension == 'pdf') {
      // Mostrar PDF
      return PDFView(
        filePath: file.path,
      );
    } else {
      // Abrir con app externa (Word, Excel, etc.)
      return Center(
        child: ElevatedButton(
          onPressed: () async {
            await OpenFile.open(file.path);
          },
          child: Text('Abrir archivo con otra aplicación'),
        ),
      );
    }
  }
}
