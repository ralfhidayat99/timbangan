import 'package:intl/intl.dart';

String formatRupiah(int value) {
  // format dengan ribuan separator dan 2 digit desimal
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
  return formatter.format(value);
}

String formatTanggal(DateTime tanggal) {
  // Daftar nama hari dalam bahasa Indonesia
  final namaHari = [
    'Minggu',
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
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
  final tanggalBulan = DateFormat.d().format(tanggal);
  final bulan = namaBulan[tanggal.month];
  final tahun = DateFormat.y().format(tanggal);

  return '$hari, $tanggalBulan $bulan $tahun';
}
