// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:timbangan/models/datatimbang_model.dart';
import 'package:timbangan/models/pelanggan_model.dart';
import 'package:timbangan/utils/formatter.dart';

Future<Uint8List> generatePdf(PdfPageFormat format, parentWidth,
    DataTimbang dataTimbang, Pelanggan pelanggan) async {
  // TimbanganController cTimbangan = TimbanganController();

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
  pw.TextStyle tdReg = pw.TextStyle(color: PdfColors.black);
  pw.TextStyle tdBold =
      pw.TextStyle(color: PdfColors.black, fontWeight: pw.FontWeight.bold);

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
                pw.Text('No.${dataTimbang.notimbang}',
                    style: pw.Theme.of(context).header1),
              ]),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text('DAFTAR TIMBANGAN MASUK',
                    style: pw.TextStyle(
                        fontSize: 21,
                        color: PdfColors.red,
                        fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 8),
              pw.Row(children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Nama Penjual / Pembeli '),
                    pw.Text('Alamat'),
                    pw.Text('No. Kendaraan '),
                  ],
                ),
                pw.Expanded(
                    child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(' : ${pelanggan.nama}'),
                    pw.Text(' : ${pelanggan.alamat}'),
                    pw.Text(' : ${dataTimbang.nopol.toUpperCase()}'),
                  ],
                )),
              ]),
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
                        padding: const pw.EdgeInsets.symmetric(vertical: 2.0),
                        child: pw.Text('Timbangan', style: th),
                      )),
                      pw.Center(child: pw.Text('Jumlah Karung', style: th)),
                      pw.Center(child: pw.Text('Kadar Air', style: th)),
                      pw.Center(child: pw.Text('Hampa', style: th)),
                    ],
                  ),
                  pw.TableRow(
                    children: <pw.Widget>[
                      pw.Center(
                          child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 5.0),
                        child: pw.Text(dataTimbang.brtTimbangan.toString()),
                      )),
                      pw.Center(child: pw.Text(dataTimbang.karung.toString())),
                      pw.Center(
                          child: pw.Text(dataTimbang.kadarAir.toString())),
                      pw.Center(child: pw.Text(dataTimbang.hampa.toString())),
                    ],
                  ),
                ],
              ),
              // pw.Divider(),
              pw.SizedBox(height: 5),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: const <int, pw.TableColumnWidth>{
                  0: pw.FlexColumnWidth(0.5),
                  1: pw.FlexColumnWidth(0.5),
                  2: pw.FlexColumnWidth(1),
                  3: pw.FlexColumnWidth(1),
                  4: pw.FlexColumnWidth(1),
                },
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: <pw.TableRow>[
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey),
                    children: <pw.Widget>[
                      pw.Center(child: pw.Text('Kampas', style: th)),
                      pw.Center(child: pw.Text('Potongan Karung', style: th)),
                      pw.Center(child: pw.Text('Berat', style: th)),
                      pw.Center(child: pw.Text('Tara', style: th)),
                      pw.Center(child: pw.Text('Netto', style: th)),
                    ],
                  ),
                  pw.TableRow(
                    children: <pw.Widget>[
                      pw.Center(
                          child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 2.0),
                        child: pw.Text(dataTimbang.kampas.toString()),
                      )),
                      pw.Center(
                          child: pw.Text(
                              (dataTimbang.karung / 2).ceil().toString())),
                      pw.Center(child: pw.Text(dataTimbang.berat.toString())),
                      pw.Center(child: pw.Text(dataTimbang.tara.toString())),
                      pw.Center(child: pw.Text(dataTimbang.netto.toString())),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Table(
                columnWidths: const <int, pw.TableColumnWidth>{
                  0: pw.FlexColumnWidth(0.5),
                  1: pw.FlexColumnWidth(0.2),
                  2: pw.FlexColumnWidth(1),
                  3: pw.FlexColumnWidth(1),
                  4: pw.FlexColumnWidth(1),
                  5: pw.FlexColumnWidth(0.3),
                },
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: <pw.TableRow>[
                  pw.TableRow(
                    children: <pw.Widget>[
                      pw.SizedBox(),
                      pw.SizedBox(),
                      pw.SizedBox(),
                      pw.Align(
                          alignment: pw.Alignment.bottomRight,
                          child: pw.Text('Jumlah', style: tdReg)),
                      pw.Align(
                          alignment: pw.Alignment.bottomRight,
                          child: pw.Text(
                              formatRupiah(
                                  dataTimbang.netto * dataTimbang.harga),
                              style: tdBold)),
                      pw.SizedBox(),
                    ],
                  ),
                  pw.TableRow(
                    children: <pw.Widget>[
                      pw.SizedBox(),
                      pw.SizedBox(),
                      pw.SizedBox(),
                      pw.Align(
                          alignment: pw.Alignment.bottomRight,
                          child: pw.Text('Ongkos Kuli')),
                      pw.Align(
                          alignment: pw.Alignment.bottomRight,
                          child: pw.Text(
                              formatRupiah(
                                  dataTimbang.kuli * dataTimbang.karung),
                              style: tdBold)),
                    ],
                  ),
                  pw.TableRow(
                    children: <pw.Widget>[
                      pw.Divider(),
                      pw.Divider(),
                      pw.Divider(),
                      pw.Divider(),
                      pw.Divider(),
                      pw.Divider(),
                    ],
                  ),
                  pw.TableRow(
                    children: <pw.Widget>[
                      pw.SizedBox(),
                      pw.SizedBox(),
                      pw.SizedBox(),
                      pw.Align(
                          alignment: pw.Alignment.bottomRight,
                          child: pw.Text('Total')),
                      pw.Align(
                          alignment: pw.Alignment.bottomRight,
                          child: pw.Text(
                              formatRupiah(
                                  (dataTimbang.netto * dataTimbang.harga) -
                                      (dataTimbang.kuli * dataTimbang.karung)),
                              style: tdBold)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );

  return pdf.save();
}
