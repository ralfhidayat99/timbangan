import '../utils/formatter.dart';

class DataTimbang {
  final String id;
  final String idPelanggan;
  final int brtTimbangan;
  final int karung;
  final int kadarAir;
  final int hampa;
  final int kampas;
  final int berat;
  final int tara;
  final int kompensasiTara;
  final int netto;
  final int harga;
  final int potonganKuli;
  final int potonganKarung;
  final int potonganAngkut;
  final String nopol;
  final String notimbang;
  final String tanggal;
  final int totalHarga;
  final bool canceled;

  DataTimbang({
    required this.id,
    required this.idPelanggan,
    required this.brtTimbangan,
    required this.karung,
    required this.kadarAir,
    required this.hampa,
    required this.kampas,
    required this.berat,
    required this.tara,
    required this.kompensasiTara,
    required this.netto,
    required this.harga,
    required this.potonganKuli,
    required this.potonganKarung,
    required this.potonganAngkut,
    required this.nopol,
    required this.notimbang,
    required this.tanggal,
    required this.totalHarga,
    required this.canceled,
  });
  DataTimbang.empty({
    this.id = '',
    this.idPelanggan = '',
    this.brtTimbangan = 0,
    this.karung = 0,
    this.kadarAir = 0,
    this.hampa = 0,
    this.kampas = 0,
    this.berat = 0,
    this.tara = 0,
    this.kompensasiTara = 0,
    this.netto = 0,
    this.harga = 0,
    this.potonganKuli = 0,
    this.potonganKarung = 0,
    this.potonganAngkut = 0,
    this.nopol = '',
    this.notimbang = '',
    this.tanggal = '',
    this.totalHarga = 0,
    this.canceled = true,
  });

  factory DataTimbang.fromJson(Map<String, dynamic> json) => DataTimbang(
      id: json['id'].toString(),
      idPelanggan: json['id_pembeli'].toString(),
      brtTimbangan:
          int.parse(json['brt_timbangan'].toString().replaceAll('.', '')),
      karung: int.parse(json['karung'].toString()),
      kadarAir: int.parse(json['KA'].toString()),
      hampa: int.parse(json['HA'].toString()),
      kampas: int.parse(json['Kampas'].toString()),
      berat: int.parse(json['Berat'].toString()),
      tara: int.parse(json['Tara'].toString()),
      kompensasiTara: int.parse(json['kompensasi_tara'].toString()),
      netto: int.parse(json['Netto'].toString()),
      harga: int.parse(json['Harga'].toString()),
      potonganKuli: int.parse(json['potongan_kuli'].toString()),
      potonganKarung: int.parse(json['potongan_karung'].toString()),
      potonganAngkut: int.parse(json['potongan_angkut'].toString()),
      nopol: json['nopol'] ?? '',
      notimbang: json['notimbang'],
      tanggal: formatTanggal(DateTime.parse(json['created_at'])),
      // tanggal: '',
      canceled: json['canceled'].toString() == '0' ? false : true,
      totalHarga: (int.parse(json['Netto'].toString()) *
              int.parse(json['Harga'].toString())) +
          int.parse(json['potongan_kuli'].toString()) +
          int.parse(json['potongan_angkut'].toString()) +
          int.parse(json['potongan_karung'].toString()));
}

class DataRekap {
  final int totalNetto;
  final int totalBayar;
  final int totalTransaksi;
  final int totalBiayaKuli;
  final int totalBiayaKarung;
  final int totalBiayaAngkut;
  final int totalKarungTerjual;
  final int rataHampa;
  final int rataKadarair;
  final int rataTara;

  DataRekap({
    required this.totalNetto,
    required this.totalBayar,
    required this.rataHampa,
    required this.rataKadarair,
    required this.totalBiayaAngkut,
    required this.totalBiayaKarung,
    required this.totalBiayaKuli,
    required this.totalKarungTerjual,
    required this.totalTransaksi,
    required this.rataTara,
  });

  DataRekap.empty({
    this.totalNetto = 0,
    this.totalBayar = 0,
    this.rataHampa = 0,
    this.rataKadarair = 0,
    this.totalBiayaAngkut = 0,
    this.totalBiayaKarung = 0,
    this.totalBiayaKuli = 0,
    this.totalKarungTerjual = 0,
    this.totalTransaksi = 0,
    this.rataTara = 0,
  });

  factory DataRekap.fromJson(Map<String, dynamic> json) => DataRekap(
        totalNetto: int.parse(json['totalNetto'].toString()),
        totalBayar: int.parse(json['totalBayar'].toString()),
        rataHampa: int.parse(json['rataHampa'].toString()),
        rataKadarair: int.parse(json['rataKadarAir'].toString()),
        totalBiayaAngkut: int.parse(json['totalBiayaAngkut'].toString()),
        totalBiayaKarung: int.parse(json['totalBiayaKarung'].toString()),
        totalBiayaKuli: int.parse(json['totalBiayaKuli'].toString()),
        totalKarungTerjual: int.parse(json['totalKarungTerjual'].toString()),
        totalTransaksi: int.parse(json['totalTransaksi'].toString()),
        rataTara: int.parse(json['rataTara'].toString()),
      );
}
