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
        kA: int.parse(json['KA'].toString()),
        hA: int.parse(json['HA'].toString()),
        hargaGabah: int.parse(json['harga_gabah'].toString()),
        hargaKuli: int.parse(json['harga_kuli'].toString()),
      );
}
