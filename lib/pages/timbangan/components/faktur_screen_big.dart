import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import 'faktur_pdf.dart';

class FakturScreenBig extends StatefulWidget {
  const FakturScreenBig({Key? key}) : super(key: key);

  @override
  State<FakturScreenBig> createState() => _FakturScreenBigState();
}

class _FakturScreenBigState extends State<FakturScreenBig> {
  List customers = [];
  String? selectedTruck;
  DateTime dateTime = DateTime.now();
  // final DateFormat tglFormat = DateFormat.yMMMMd('id');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double parentWidth = 565;

    return Scaffold(
      appBar: AppBar(title: const Text('Cetak')),
      body: Row(
        children: [
          Expanded(
            child: PdfPreview(
              // maxPageWidth: 900,
              shouldRepaint: true,

              build: (format) => generatePdf(format, parentWidth),
            ),
          ),
        ],
      ),
    );
  }
}
