class StandardData {
  final String id;
  final int kA;
  final int hA;
  final int hargaGabah;
  final int hargaKuli;
  final int hargaKarung;
  final int hargaAngkut;

  StandardData({
    required this.id,
    required this.kA,
    required this.hA,
    required this.hargaGabah,
    required this.hargaKuli,
    required this.hargaKarung,
    required this.hargaAngkut,
  });

  StandardData.empty({
    this.id = '',
    this.kA = 0,
    this.hA = 0,
    this.hargaGabah = 0,
    this.hargaKarung = 0,
    this.hargaKuli = 0,
    this.hargaAngkut = 0,
  });

  factory StandardData.fromJson(Map<String, dynamic> json) => StandardData(
        id: json['id'].toString(),
        kA: int.parse(json['kadar_air'].toString().replaceAll('.', '')),
        hA: int.parse(json['hampa'].toString().replaceAll('.', '')),
        hargaGabah:
            int.parse(json['harga_gabah'].toString().replaceAll('.', '')),
        hargaKuli: int.parse(json['harga_kuli'].toString().replaceAll('.', '')),
        hargaKarung:
            int.parse(json['harga_karung'].toString().replaceAll('.', '')),
        hargaAngkut:
            int.parse(json['harga_angkut'].toString().replaceAll('.', '')),
      );
}
