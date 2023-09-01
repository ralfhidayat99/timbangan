// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:timbangan/controllers/timbangan_controller.dart';

Future<Uint8List> generatePdf(PdfPageFormat format, parentWidth) async {
  // TimbanganController cTimbangan = TimbanganController();
  final cTimbangan = Get.put(TimbanganController());

  final pdf = pw.Document(
    version: PdfVersion.pdf_1_5,
    compress: true,
  );

  final pw.TextStyle tContent = pw.TextStyle(
      fontSize: 9, color: PdfColors.black, fontWeight: pw.FontWeight.bold);
  pw.TextStyle thead1 =
      pw.TextStyle(fontSize: 21, fontWeight: pw.FontWeight.bold);
  pw.TextStyle th =
      pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold);

  pdf.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.all(15),
      pageFormat: format,
      build: (context) {
        return pw.Container(
          width: parentWidth,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(children: [
                pw.Container(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('PT. RATU MAKMUR ABADI', style: thead1),
                        pw.Text(
                          'Singojuruh - Banyuwangi',
                          style: tContent,
                        ),
                        pw.Text('Telp. (03333) 86564', style: tContent),
                      ],
                    )),
                pw.Spacer(),
                pw.Text('No ${cTimbangan.noTimbang}',
                    style: pw.Theme.of(context).header1),
              ]),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text('DAFTAR TIMBANGAN MASUK / KELUAR',
                    style: pw.TextStyle(
                        fontSize: 21,
                        color: PdfColors.red,
                        fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 8),
              pw.Text('Nama Penjual / Pembeli :'),
              pw.Text('Alamat:'),
              pw.Text('No. Kendaraan :'),
              pw.SizedBox(height: 3),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: const <int, pw.TableColumnWidth>{
                  0: pw.FlexColumnWidth(1),
                  1: pw.FlexColumnWidth(1),
                  2: pw.FlexColumnWidth(1),
                  3: pw.FlexColumnWidth(1),
                },
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: <pw.TableRow>[
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey),
                    children: <pw.Widget>[
                      pw.Center(
                          child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 5.0),
                        child: pw.Text('Timbangan', style: th),
                      )),
                      pw.Center(child: pw.Text('Karung', style: th)),
                      pw.Center(child: pw.Text('KA', style: th)),
                      pw.Center(child: pw.Text('HA', style: th)),
                    ],
                  ),
                  pw.TableRow(
                    children: <pw.Widget>[
                      pw.Center(
                          child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 5.0),
                        child: pw.Text('Timbangan'),
                      )),
                      pw.Center(child: pw.Text('Karung')),
                      pw.Center(child: pw.Text('KA')),
                      pw.Center(child: pw.Text('HA')),
                    ],
                  ),
                ],
              ),
              // pw.Divider(),
              pw.SizedBox(height: 5),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: const <int, pw.TableColumnWidth>{
                  0: pw.FlexColumnWidth(1),
                  1: pw.FlexColumnWidth(1),
                  2: pw.FlexColumnWidth(1),
                  3: pw.FlexColumnWidth(1),
                },
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: <pw.TableRow>[
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey),
                    children: <pw.Widget>[
                      pw.Center(
                          child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 5.0),
                        child: pw.Text('Kampas', style: th),
                      )),
                      pw.Center(child: pw.Text('Berat', style: th)),
                      pw.Center(child: pw.Text('Tara', style: th)),
                      pw.Center(child: pw.Text('Netto', style: th)),
                    ],
                  ),
                  pw.TableRow(
                    children: <pw.Widget>[
                      pw.Center(
                          child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 5.0),
                        child: pw.Text('Timbangan'),
                      )),
                      pw.Center(child: pw.Text('Karung')),
                      pw.Center(child: pw.Text('KA')),
                      pw.Center(child: pw.Text('HA')),
                    ],
                  ),
                ],
              ),
              pw.Row(children: [
                pw.Spacer(),
                pw.SizedBox(
                    width: 150,
                    child: pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Jumlah'),
                            pw.Text('19000'),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Ongkos Kuli'),
                            pw.Text('19000'),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Total'),
                            pw.Text('19000'),
                          ],
                        ),
                      ],
                    ))
              ]),
            ],
          ),
        );
      },
    ),
  );

  return pdf.save();
}
