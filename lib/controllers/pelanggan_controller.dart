import 'package:get/get.dart';
import 'package:timbangan/models/pelanggan_model.dart';
import 'package:timbangan/utils/Rest.dart';

class PelangganController extends GetxController {
  static List<Pelanggan> pelanggans = [];
  static Rx<Pelanggan> selectedPelanggan = Pelanggan.empty().obs;

  static void getAllCustomers() async {
    List res = await Rest().getR('customers');
    pelanggans = res.map((e) => Pelanggan.fromJson(e)).toList();
  }

  static List<Pelanggan> getSuggestions(String query) {
    List<Pelanggan> matches = <Pelanggan>[];
    matches.addAll(pelanggans);

    matches
        .retainWhere((s) => s.nama.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  static Future addCustomer(String nama, String alamat) async {
    var data = {
      'nama': nama,
      'alamat': alamat,
    };
    var res = await Rest().postR('customers', data);
    selectedPelanggan.value = Pelanggan.fromJson(res['data']);
  }
}
