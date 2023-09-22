import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:timbangan/controllers/timbangan_controller.dart';
import 'package:timbangan/models/datatimbang_model.dart';

import '../../../models/pelanggan_model.dart';
import 'faktur_pdf.dart';

class FakturScreenBig extends StatefulWidget {
  const FakturScreenBig({Key? key, required this.data, required this.pelanggan})
      : super(key: key);
  final DataTimbang data;
  final Pelanggan pelanggan;

  @override
  State<FakturScreenBig> createState() => _FakturScreenBigState();
}

class _FakturScreenBigState extends State<FakturScreenBig> {
  List customers = [];
  String? selectedTruck;
  DateTime dateTime = DateTime.now();
  // final DateFormat tglFormat = DateFormat.yMMMMd('id');
  TimbanganController cDatatimbang = TimbanganController();

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

              build: (format) => generatePdf(
                  format, parentWidth, widget.data, widget.pelanggan),
            ),
          ),
        ],
      ),
    );
  }
}
