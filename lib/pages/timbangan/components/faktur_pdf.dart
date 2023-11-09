// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';
import 'package:get_storage/get_storage.dart';
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
  final box = GetStorage();
  var pabrik = box.read('pabrik');

  final pw.TextStyle tContent = pw.TextStyle(
      fontSize: 9, color: PdfColors.black, fontWeight: pw.FontWeight.bold);
  pw.TextStyle thead1 =
      pw.TextStyle(fontSize: 21, fontWeight: pw.FontWeight.bold);
  pw.TextStyle th =
      pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold);
  pw.TextStyle tdReg = const pw.TextStyle(color: PdfColors.black);
  pw.TextStyle tdSmall =
      const pw.TextStyle(color: PdfColors.black, fontSize: 8);
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
                        pw.Text(pabrik['name'].toString().toUpperCase(),
                            style: thead1),
                        pw.Text(
                          pabrik['address'],
                          style: tContent,
                        ),
                        pw.Text('Telp. ${pabrik['phone']}', style: tContent),
                      ],
                    )),
                pw.Spacer(),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(dataTimbang.tanggal),
                    pw.Text('No.${dataTimbang.notimbang}',
                        style: pw.Theme.of(context).header1),
                  ],
                ),
              ]),
              pw.SizedBox(height: 5),
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
                      // pw.Center(child: pw.Text('Kampas', style: th)),
                      // pw.Center(
                      //     child: pw.Column(
                      //   children: [
                      //     pw.Text('Potongan',
                      //         style: pw.TextStyle(
                      //             fontSize: 10,
                      //             color: PdfColors.white,
                      //             fontWeight: pw.FontWeight.bold)),
                      //     pw.Text('Karung',
                      //         style: pw.TextStyle(
                      //             fontSize: 10,
                      //             color: PdfColors.white,
                      //             fontWeight: pw.FontWeight.bold)),
                      //   ],
                      // )),
                      pw.Center(child: pw.Text('Potongan Karung', style: th)),
                      pw.Center(child: pw.Text('Berat', style: th)),
                      pw.Center(child: pw.Text('Tara', style: th)),
                      pw.Center(child: pw.Text('Netto', style: th)),
                    ],
                  ),
                  pw.TableRow(
                    children: <pw.Widget>[
                      // pw.Center(
                      //     child: pw.Padding(
                      //   padding: const pw.EdgeInsets.symmetric(vertical: 2.0),
                      //   child: pw.Text(dataTimbang.kampas.toString()),
                      // )),
                      pw.Center(
                          child: pw.Text(
                              (dataTimbang.karung / 2).ceil().toString())),
                      pw.Center(child: pw.Text(dataTimbang.berat.toString())),
                      pw.Center(
                          child: pw.Text(
                              '${dataTimbang.tara} - ${dataTimbang.kompensasiTara}')),
                      pw.Center(child: pw.Text(dataTimbang.netto.toString())),
                    ],
                  ),
                ],
              ),
              pw.Divider(height: 30),
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Table(border: pw.TableBorder.all(), children: [
                          pw.TableRow(
                            children: <pw.Widget>[
                              pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.all(8),
                                  child: pw.Text('Penimbang', style: tdSmall)),
                              pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.all(8),
                                  child: pw.Text('Jr.Rafaksi', style: tdSmall)),
                              pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.all(8),
                                  child: pw.Text('Jr.Kerani', style: tdSmall)),
                              pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.all(8),
                                  child: pw.Text('Penjual', style: tdSmall)),
                              pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.all(8),
                                  child: pw.Text('Korektor', style: tdSmall)),
                              pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.all(8),
                                  child: pw.Text('Pembuku', style: tdSmall)),
                            ],
                          ),
                          pw.TableRow(
                            children: <pw.Widget>[
                              pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.all(20),
                                  child: pw.Text('', style: tdReg)),
                              pw.Container(
                                  alignment: pw.Alignment.center,
                                  padding: const pw.EdgeInsets.all(20),
                                  child: pw.Text('', style: tdReg)),
                            ],
                          ),
                        ]),
                        pw.SizedBox(height: 3),
                        pw.Text(
                            '@Harga Gabah: Rp ${formatRupiah(dataTimbang.harga)}',
                            style: pw.TextStyle(
                                fontSize: 8, fontStyle: pw.FontStyle.italic))
                      ],
                    ),
                    pw.Spacer(),
                    pw.SizedBox(
                      width: 250,
                      child: pw.Table(
                        // border: pw.TableBorder.all(),
                        defaultVerticalAlignment:
                            pw.TableCellVerticalAlignment.middle,
                        children: <pw.TableRow>[
                          pw.TableRow(
                            children: <pw.Widget>[
                              pw.Align(
                                  alignment: pw.Alignment.bottomRight,
                                  child:
                                      pw.Text('Jumlah Kotor :', style: tdReg)),
                              pw.Align(
                                  alignment: pw.Alignment.bottomRight,
                                  child: pw.Text(
                                      formatRupiah(dataTimbang.netto *
                                          dataTimbang.harga),
                                      style: tdBold)),
                              pw.SizedBox(),
                            ],
                          ),
                          pw.TableRow(
                            children: <pw.Widget>[
                              pw.Align(
                                  alignment: pw.Alignment.bottomRight,
                                  child: pw.Text('Potongan Kuli :')),
                              pw.Align(
                                  alignment: pw.Alignment.bottomRight,
                                  child: pw.Text(
                                      formatRupiah(dataTimbang.potonganKuli),
                                      style: tdBold)),
                            ],
                          ),
                          pw.TableRow(
                            children: <pw.Widget>[
                              pw.Align(
                                  alignment: pw.Alignment.bottomRight,
                                  child: pw.Text('Potongan Karung :')),
                              pw.Align(
                                  alignment: pw.Alignment.bottomRight,
                                  child: pw.Text(
                                      formatRupiah(dataTimbang.potonganKarung),
                                      style: tdBold)),
                            ],
                          ),
                          pw.TableRow(
                            children: <pw.Widget>[
                              pw.Align(
                                  alignment: pw.Alignment.bottomRight,
                                  child: pw.Text('Potongan Angkut :')),
                              pw.Align(
                                  alignment: pw.Alignment.bottomRight,
                                  child: pw.Text(
                                      formatRupiah(dataTimbang.potonganAngkut),
                                      style: tdBold)),
                            ],
                          ),
                          pw.TableRow(
                            children: <pw.Widget>[
                              pw.Divider(),
                              pw.Divider(),
                              pw.Divider(),
                              pw.Divider(),
                            ],
                          ),
                          pw.TableRow(
                            children: <pw.Widget>[
                              pw.Align(
                                  alignment: pw.Alignment.bottomRight,
                                  child: pw.Text('Total',
                                      style: pw.TextStyle(
                                          fontSize: 18,
                                          fontWeight: pw.FontWeight.normal))),
                              pw.Align(
                                  alignment: pw.Alignment.bottomRight,
                                  child: pw.Text(
                                      'Rp ${formatRupiah((dataTimbang.totalHarga))}',
                                      style: pw.TextStyle(
                                          fontSize: 18,
                                          fontWeight: pw.FontWeight.normal))),
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
            ],
          ),
        );
      },
    ),
  );

  return pdf.save();
}
