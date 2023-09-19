import '../utils/formatter.dart';

class DataTimbang {
  final String id;
  final int brtTimbangan;
  final int karung;
  final int kadarAir;
  final int hampa;
  final int kampas;
  final int berat;
  final int tara;
  final int netto;
  final int harga;
  final String idPembeli;
  final int kuli;
  final String nopol;
  final String notimbang;
  final String tanggal;

  DataTimbang({
    required this.id,
    required this.brtTimbangan,
    required this.karung,
    required this.kadarAir,
    required this.hampa,
    required this.kampas,
    required this.berat,
    required this.tara,
    required this.netto,
    required this.harga,
    required this.idPembeli,
    required this.kuli,
    required this.nopol,
    required this.notimbang,
    required this.tanggal,
  });
  DataTimbang.empty({
    this.id = '',
    this.brtTimbangan = 0,
    this.karung = 0,
    this.kadarAir = 0,
    this.hampa = 0,
    this.kampas = 0,
    this.berat = 0,
    this.tara = 0,
    this.netto = 0,
    this.harga = 0,
    this.idPembeli = '',
    this.kuli = 0,
    this.nopol = '',
    this.notimbang = '',
    this.tanggal = '',
  });

  factory DataTimbang.fromJson(Map<String, dynamic> json) => DataTimbang(
        id: json['id'].toString(),
        brtTimbangan: json['brt_timbangan'],
        karung: json['karung'],
        kadarAir: json['KA'],
        hampa: json['HA'],
        kampas: json['Kampas'],
        berat: json['Berat'],
        tara: json['Tara'],
        netto: json['Netto'],
        harga: json['Harga'],
        idPembeli: json['id_pembeli'].toString(),
        kuli: json['kuli'],
        nopol: json['nopol'] ?? '',
        notimbang: json['id'].toString().padLeft(6, '0'),
        tanggal: formatTanggal(DateTime.parse(json['created_at'])),
      );
}
