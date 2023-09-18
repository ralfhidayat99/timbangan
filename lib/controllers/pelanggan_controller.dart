import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/models/pelanggan_model.dart';
import 'package:timbangan/utils/Rest.dart';

class PelangganController extends GetxController {
  static List<Pelanggan> pelanggans = [];
  static Rx<Pelanggan> selectedPelanggan = Pelanggan.empty().obs;
  static RxBool isProcessing = false.obs;
  static TextEditingController tAlamat = TextEditingController();
  static TextEditingController tNama = TextEditingController();

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

  static Future addCustomer() async {
    isProcessing.value = true;
    var data = {
      'nama': tNama.text,
      'alamat': tAlamat.text,
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
}
