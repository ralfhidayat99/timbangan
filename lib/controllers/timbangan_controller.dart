import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timbangan/models/Standard_model.dart';
import 'package:timbangan/utils/Rest.dart';

class TimbanganController extends GetxController {
  TextEditingController cTimbangan = TextEditingController();
  TextEditingController cKarung = TextEditingController();
  TextEditingController cKA = TextEditingController();
  TextEditingController cHA = TextEditingController();

  RxInt kampas = 0.obs,
      berat = 0.obs,
      tara = 0.obs,
      netto = 0.obs,
      totalHrg = 0.obs,
      ongKuli = 0.obs;
  RxString hrgGabahView = ''.obs;
  RxString ongKuliView = ''.obs;
  RxString noTimbang = '000000'.obs;
  StandardData stdData =
      StandardData(id: '1', kA: 0, hA: 0, hargaGabah: 0, hargaKuli: 0);
  RxBool isProcessing = false.obs;
  RxBool isGettingData = false.obs;

  @override
  void onInit() {
    super.onInit();
    getInitData();
  }

  Future getInitData() async {
    isGettingData.value = true;
    var response = await Rest().getR('datatimbang');
    stdData = StandardData.fromJson(response['standar']);
    hrgGabahView.value = stdData.hargaGabah.toString();
    ongKuliView.value = stdData.hargaKuli.toString();
    noTimbang.value = response['notimbangan'].toString();
    isGettingData.value = false;
    // print(stdData.hargaGabah);
  }

  Future createDataTimbang() async {
    isProcessing.value = true;
    var data = {
      "brt_timbangan": cTimbangan.text,
      "karung": cKarung.text,
      "KA": cKA.text,
      "HA": cHA.text,
      "Kampas": kampas.value,
      "Berat": berat.value,
      "Tara": tara.value,
      "Netto": netto.value,
      "Harga": stdData.hargaGabah
    };
    var response = await Rest().postR('datatimbang', data);
    print(response);
    getInitData();
    isProcessing.value = false;
  }

  Future updateHarga(harga) async {
    await Rest().postR('harga/${stdData.id}', harga);
    await getInitData();
    Get.back();
    hitungKampas();
    hitungTara();
  }

  static Future getDataTimbang() async {
    var response = await Rest().getR('listtimbangan');
    return response;
  }

  void hitungKampas() {
    int timbangan = cTimbangan.text == '' ? 0 : int.parse(cTimbangan.text);
    int karung = cKarung.text == '' ? 0 : int.parse(cKarung.text);

    kampas.value = (karung * 1.5).ceil();
    berat.value = timbangan - kampas.value - (karung * 0.5).ceil();
    ongKuli.value = karung * stdData.hargaKuli;
    hitungTara();
  }

  void hitungTara() {
    int kA = cKA.text == '' ? 0 : int.parse(cKA.text);
    int hA = cHA.text == '' ? 0 : int.parse(cHA.text);

    int kaStandard = stdData.kA;
    int haStandard = stdData.hA;

    tara.value = (kA - kaStandard) + (hA - haStandard);
    netto.value = berat.value - (tara.value * berat.value / 100).ceil();
    totalHrg.value = stdData.hargaGabah * netto.value - ongKuli.value;
    // netto.value = berat.value;
  }

  String formatRupiah(int value) {
    // format dengan ribuan separator dan 2 digit desimal
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
    return 'Rp ${formatter.format(value)}';
  }
}
