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

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double parentWidth = 565;
    TextEditingController tKeterangan = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Faktur')),
      body: Row(
        children: [
          Card(
              child: Container(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Adjusment",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tanggal Faktur'),
                      OutlinedButton(
                        onPressed: () async {
                          DateTime? newSelectedDate = await showDatePicker(
                              locale: const Locale("id", "ID"),
                              context: context,
                              initialDate: dateTime,
                              firstDate: DateTime(dateTime.year - 1),
                              lastDate: DateTime(dateTime.year + 1));

                          if (newSelectedDate != null) {
                            setState(() {});
                          }
                        },
                        child: Text('galFaktur)'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tanggal Kirim'),
                      OutlinedButton(
                        onPressed: () async {
                          DateTime? newSelectedDate = await showDatePicker(
                              locale: const Locale("id", "ID"),
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2024));

                          if (newSelectedDate != null) {
                            setState(() {});
                          }
                        },
                        child: Text('im)'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: tKeterangan,
                          decoration: const InputDecoration(
                            labelText: 'Keterangan',
                          ),
                          onChanged: (t) {},
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(Icons.check))
                    ],
                  ),
                ],
              ),
            ),
          )),
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
