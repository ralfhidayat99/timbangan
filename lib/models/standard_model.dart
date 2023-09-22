class StandardData {
  final String id;
  final int kA;
  final int hA;
  final int hargaGabah;
  final int hargaKuli;
  final int hargaKarung;

  StandardData({
    required this.id,
    required this.kA,
    required this.hA,
    required this.hargaGabah,
    required this.hargaKuli,
    required this.hargaKarung,
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
      );
}
