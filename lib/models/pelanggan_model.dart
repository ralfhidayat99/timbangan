class Pelanggan {
  final String id;
  final String nama;
  final String alamat;

  Pelanggan({
    required this.id,
    required this.nama,
    required this.alamat,
  });
  Pelanggan.empty({
    this.id = '',
    this.nama = '',
    this.alamat = '',
  });

  factory Pelanggan.fromJson(Map<String, dynamic> json) => Pelanggan(
        id: json['id'].toString(),
        nama: json['nama'],
        alamat: json['alamat'],
      );
}
