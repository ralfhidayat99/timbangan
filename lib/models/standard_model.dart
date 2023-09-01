class StandardData {
  final String id;
  final int kA;
  final int hA;
  final int hargaGabah;
  final int hargaKuli;

  StandardData({
    required this.id,
    required this.kA,
    required this.hA,
    required this.hargaGabah,
    required this.hargaKuli,
  });

  factory StandardData.fromJson(Map<String, dynamic> json) => StandardData(
        id: json['id'].toString(),
        kA: json['KA'],
        hA: json['HA'],
        hargaGabah: json['harga_gabah'],
        hargaKuli: json['harga_kuli'],
      );
}
