import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timbangan/models/pelanggan_model.dart';
import 'package:timbangan/utils/Rest.dart';

class PelangganController extends GetxController {
  static List<Pelanggan> pelanggans = [];
  static Rx<Pelanggan> selectedPelanggan = Pelanggan.empty().obs;
  static RxBool isProcessing = false.obs;
  static TextEditingController tAlamat = TextEditingController();
  static TextEditingController tNama = TextEditingController();
  static final box = GetStorage();
  static var user = box.read('user');

  static void getAllCustomers() async {
    var user = box.read('user');
    List res = await Rest().getR('customers/${user['id']}');
    pelanggans = res.map((e) => Pelanggan.fromJson(e)).toList();
  }

  static List<Pelanggan> getSuggestions(String query) {
    List<Pelanggan> matches = <Pelanggan>[];
    matches.addAll(pelanggans);

    matches
        .retainWhere((s) => s.nama.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  static Future addCustomer() async {
    isProcessing.value = true;
    var data = {
      'nama': tNama.text,
      'alamat': tAlamat.text,
      'factory_id': user['factory_id'],
    };
    var res = await Rest().postR('customers', data);
    selectedPelanggan.value = Pelanggan.fromJson(res['data']);
    getAllCustomers();
    isProcessing.value = false;
  }

  static Pelanggan findById(String id) {
    for (var pelanggan in pelanggans) {
      if (pelanggan.id == id) {
        return pelanggan;
      }
    }
    return Pelanggan
        .empty(); // Mengembalikan null jika pelanggan tidak ditemukan
  }

  static Future getTopCust() async {
    List response = await Rest().getR('topcustomer');
    return response;
  }
}
