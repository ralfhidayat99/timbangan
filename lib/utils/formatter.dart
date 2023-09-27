import 'package:intl/intl.dart';

String formatRupiah(int value) {
  // format dengan ribuan separator dan 2 digit desimal
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
  return formatter.format(value);
}

String formatTonase(double value) {
  // format dengan ribuan separator dan 2 digit desimal
  String satuan = 'Kg';
  if (value >= 100 && value < 1000) {
    satuan = 'Kw';
    value = value / 100;
  }
  if (value >= 1000) {
    satuan = 'Ton';
    value = value / 1000;
  }
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 2);
  var tonase = formatter.format(value);
  return '$tonase $satuan';
}

String formatTanggal(DateTime tanggal) {
  // Daftar nama hari dalam bahasa Indonesia
  final namaHari = [
    '',
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  // Daftar nama bulan dalam bahasa Indonesia
  final namaBulan = [
    '',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  final hari = namaHari[tanggal.weekday];
  // final hari = tanggal.weekday;
  final tanggalBulan = DateFormat.d().format(tanggal);
  final bulan = namaBulan[tanggal.month];
  final tahun = DateFormat.y().format(tanggal);

  return '$hari, $tanggalBulan $bulan $tahun';
}
