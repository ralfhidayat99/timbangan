import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/controllers/pelanggan_controller.dart';
import 'package:timbangan/models/Standard_model.dart';
import 'package:timbangan/models/datatimbang_model.dart';
import 'package:timbangan/utils/Rest.dart';

class TimbanganController extends GetxController {
  TextEditingController cTimbangan = TextEditingController();
  TextEditingController cKarung = TextEditingController();
  TextEditingController cKA = TextEditingController();
  TextEditingController cHA = TextEditingController();
  TextEditingController tNopol = TextEditingController();

  RxInt kampas = 0.obs,
      berat = 0.obs,
      tara = 0.obs,
      netto = 0.obs,
      jmlHrg = 0.obs,
      totalHrg = 0.obs,
      ongKuli = 0.obs;
  RxInt hrgGabahView = 0.obs;
  RxInt ongKuliView = 0.obs;
  RxString noTimbang = '000000'.obs;
  StandardData stdData =
      StandardData(id: '1', kA: 0, hA: 0, hargaGabah: 0, hargaKuli: 0);
  RxBool isProcessing = false.obs;
  RxBool isGettingData = false.obs;
  DataTimbang dataTobePrint = DataTimbang.empty();

  @override
  void onInit() {
    super.onInit();
    getInitData();
    PelangganController.getAllCustomers();
  }

  Future getInitData() async {
    isGettingData.value = true;
    var response = await Rest().getR('datatimbang');
    stdData = StandardData.fromJson(response['standar']);
    hrgGabahView.value = stdData.hargaGabah;
    ongKuliView.value = stdData.hargaKuli;
    noTimbang.value = response['notimbangan'].toString();
    isGettingData.value = false;
    // print(stdData.hargaGabah);
  }

  Future createDataTimbang() async {
    if (PelangganController.selectedPelanggan.value.id != '') {
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
        "Harga": stdData.hargaGabah,
        "id_pembeli": PelangganController.selectedPelanggan.value.id,
        "kuli": stdData.hargaKuli,
        "nopol": tNopol.text,
      };
      var response = await Rest().postR('datatimbang', data);
      dataTobePrint = DataTimbang.fromJson(response['data']);
      getInitData();
      isProcessing.value = false;
    }
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
    List daftar = response['timbangan'];
    daftar = daftar.map((e) => DataTimbang.fromJson(e)).toList();
    return daftar;
  }

  void hitungKampas() {
    int timbangan = cTimbangan.text == '' ? 0 : int.parse(cTimbangan.text);
    int karung = cKarung.text == '' ? 0 : int.parse(cKarung.text);

    kampas.value = (karung * 1.5).ceil();
    berat.value = timbangan - kampas.value - (karung * 0.5).ceil();
    berat.value = berat < 0 ? 0 : berat.value;
    ongKuli.value = karung * stdData.hargaKuli;
    hitungTara();
  }

  void hitungTara() {
    int kA = cKA.text == '' ? 0 : int.parse(cKA.text);
    int hA = cHA.text == '' ? 0 : int.parse(cHA.text);

    int kaStandard = stdData.kA;
    int haStandard = stdData.hA;

    tara.value = ((kA - kaStandard) + (hA - haStandard));
    tara.value = tara.value < 0 ? 0 : tara.value;
    netto.value = berat.value - (tara.value * berat.value / 100).ceil();
    jmlHrg.value = stdData.hargaGabah * netto.value;
    totalHrg.value = stdData.hargaGabah * netto.value - ongKuli.value;
    // netto.value = berat.value;
  }
}
