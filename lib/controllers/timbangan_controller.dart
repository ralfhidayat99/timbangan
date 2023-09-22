import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timbangan/controllers/pelanggan_controller.dart';
import 'package:timbangan/models/datatimbang_model.dart';
import 'package:timbangan/utils/Rest.dart';

import '../models/standard_model.dart';

class TimbanganController extends GetxController {
  TextEditingController cTimbangan = TextEditingController();
  TextEditingController cKarung = TextEditingController();
  TextEditingController cKA = TextEditingController();
  TextEditingController cHA = TextEditingController();
  TextEditingController tNopol = TextEditingController();
  TextEditingController tPotonganAngkut = TextEditingController();

  RxInt kampas = 0.obs,
      berat = 0.obs,
      tara = 0.obs,
      netto = 0.obs,
      jmlHrg = 0.obs,
      totalHrg = 0.obs,
      ongKuli = 0.obs,
      ongAngkut = 0.obs,
      ongKarung = 0.obs;
  RxInt hrgGabahView = 0.obs;
  RxInt ongKuliView = 0.obs;
  RxString noTimbang = '000000'.obs;
  static Rx<StandardData> stdData = StandardData(
          id: '', kA: 0, hA: 0, hargaGabah: 0, hargaKuli: 0, hargaKarung: 0)
      .obs;
  RxBool isProcessing = false.obs;
  RxBool isGettingData = false.obs;
  DataTimbang dataTobePrint = DataTimbang.empty();
  static RxBool potonganAngkut = false.obs;
  static RxBool potonganKuli = false.obs;
  static RxBool potonganKarung = false.obs;
  static final box = GetStorage();
  var user = box.read('user');

  @override
  void onInit() {
    super.onInit();
    getInitData();
    PelangganController.getAllCustomers();
  }

  Future getInitData() async {
    isGettingData.value = true;
    var response = await Rest().getR('datatimbang/${user['factory_id']}');
    stdData.value = StandardData.fromJson(response['standar']);
    hrgGabahView.value = stdData.value.hargaGabah;
    ongKuliView.value = stdData.value.hargaKuli;
    noTimbang.value = response['notimbangan'].toString();
    isGettingData.value = false;
    // print(stdData.hargaGabah);
  }

  Future createDataTimbang() async {
    if (PelangganController.selectedPelanggan.value.id != '') {
      isProcessing.value = true;
      var data = {
        "factory_id": user['factory_id'],
        "notimbang": noTimbang.value,
        "brt_timbangan": cTimbangan.text,
        "karung": cKarung.text,
        "KA": cKA.text,
        "HA": cHA.text,
        "Kampas": kampas.value,
        "Berat": berat.value,
        "Tara": tara.value,
        "Netto": netto.value,
        "Harga": stdData.value.hargaGabah,
        "id_pembeli": PelangganController.selectedPelanggan.value.id,
        "potongan_kuli": potonganKuli.value ? ongKuli.value : 0,
        "potongan_karung": potonganKarung.value ? ongKarung.value : 0,
        "potongan_angkut": potonganAngkut.value ? ongAngkut.value : 0,
        "nopol": tNopol.text,
      };
      var response = await Rest().postR('datatimbang', data);

      dataTobePrint = DataTimbang.fromJson(response['data']);
      // getInitData();
      isProcessing.value = false;
    }
  }

  Future updateHarga(harga) async {
    await Rest().postR('harga/${stdData.value.id}', harga);
    await getInitData();
    Get.back();
    hitungKampas();
    hitungTara();
  }

  static Future updateStandar(harga) async {
    var response = await Rest().postR('harga/${stdData.value.id}', harga);
    stdData.value = StandardData.fromJson(response);

    Get.back();
  }

  static Future getDataTimbang() async {
    var user = box.read('user');
    var response = await Rest().getR('listtimbangan/${user['factory_id']}');
    List daftar = response['timbangan'];
    daftar = daftar.map((e) => DataTimbang.fromJson(e)).toList();
    return daftar;
  }

  void hitungKampas() {
    int timbangan = cTimbangan.text == ''
        ? 0
        : int.parse(cTimbangan.text.replaceAll('.', ''));
    int karung =
        cKarung.text == '' ? 0 : int.parse(cKarung.text.replaceAll('.', ''));

    kampas.value = (karung * 1.5).ceil();
    berat.value = timbangan - kampas.value - (karung * 0.5).ceil();
    berat.value = berat < 0 ? 0 : berat.value;
    ongKuli.value = karung * stdData.value.hargaKuli;
    ongKarung.value = karung * stdData.value.hargaKarung;
    ongAngkut.value = tPotonganAngkut.text == ''
        ? 0
        : int.parse(tPotonganAngkut.text.replaceAll('.', ''));
    hitungTara();
  }

  void hitungTara() {
    int kA = cKA.text == '' ? 0 : int.parse(cKA.text.replaceAll('.', ''));
    int hA = cHA.text == '' ? 0 : int.parse(cHA.text.replaceAll('.', ''));

    int kaStandard = stdData.value.kA;
    int haStandard = stdData.value.hA;

    tara.value = ((kA - kaStandard) + (hA - haStandard));
    tara.value = tara.value < 0 ? 0 : tara.value;
    netto.value = berat.value - (tara.value * berat.value / 100).ceil();
    jmlHrg.value = stdData.value.hargaGabah * netto.value;
    totalHrg.value = stdData.value.hargaGabah * netto.value;
    if (potonganAngkut.value) {
      totalHrg.value = totalHrg.value - ongAngkut.value;
    }
    if (potonganKuli.value) {
      // print(potonganKuli);
      totalHrg.value = totalHrg.value - ongKuli.value;
    }
    if (potonganKarung.value) {
      totalHrg.value = totalHrg.value - ongKarung.value;
    }
    // netto.value = berat.value;
  }

  @override
  void dispose() {
    cTimbangan.clear();
    cKarung.clear();
    cKA.clear();
    cHA.clear();
    tNopol.clear();
    super.dispose();
  }
}
