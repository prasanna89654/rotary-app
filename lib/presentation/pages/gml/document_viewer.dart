import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;

class DocumentViewer extends StatefulWidget {
  final String filePath;
  final String title;
  const DocumentViewer({Key? key, required this.filePath, required this.title})
      : super(key: key);

  @override
  State<DocumentViewer> createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  bool isLoading = true;

  Uint8List? pdfData;
  @override
  void initState() {
    super.initState();
    getPdfData();
  }

  getPdfData() async {
    if (widget.filePath != "") {
      pdfData = pdfData = await http.readBytes(Uri.parse(widget.filePath));
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : pdfData != null
              ? PDFView(pdfData: pdfData)
              : Center(
                  child: Text("No document found."),
                ),
    );
  }
}
