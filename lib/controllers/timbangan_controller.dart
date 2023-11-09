import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/controllers/pelanggan_controller.dart';
import 'package:timbangan/home.dart';
import 'package:timbangan/models/datatimbang_model.dart';
import 'package:timbangan/utils/Rest.dart';
import 'package:timbangan/utils/storage.dart';

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
      kompensasiTara = 0.obs,
      netto = 0.obs,
      jmlHrg = 0.obs,
      totalHrg = 0.obs,
      ongKuli = 0.obs,
      ongAngkut = 0.obs,
      ongKarung = 0.obs;
  RxInt hrgGabahView = 0.obs;
  RxInt ongKuliView = 0.obs;
  RxString noTimbang = '000000'.obs;
  RxBool isProcessing = false.obs;
  RxBool isGettingData = false.obs;
  DataTimbang dataTobePrint = DataTimbang.empty();
  static Rx<StandardData> stdData = StandardData.empty().obs;
  static Rx<DataRekap> rekap = DataRekap.empty().obs;
  static RxBool potonganAngkut = false.obs;
  static RxBool potonganKuli = false.obs;
  static RxBool potonganKarung = false.obs;
  static DataStorage storage = DataStorage();

  @override
  void onInit() {
    super.onInit();
    getInitData();
    PelangganController.getAllCustomers();
  }

  Future getInitData() async {
    var pabrik = storage.box.read('pabrik');

    isGettingData.value = true;
    var response = await Rest().getR('datatimbang/${pabrik['id']}');
    stdData.value = StandardData.fromJson(response['standar']);
    hrgGabahView.value = stdData.value.hargaGabah;
    ongKuliView.value = stdData.value.hargaKuli;
    noTimbang.value = response['notimbangan'].toString();
    isGettingData.value = false;
    // print(stdData.hargaGabah);
  }

  Future createDataTimbang() async {
    var pabrik = storage.box.read('pabrik');

    if (PelangganController.selectedPelanggan.value.id != '') {
      isProcessing.value = true;
      var data = {
        "factory_id": pabrik['id'],
        "notimbang": noTimbang.value,
        "brt_timbangan": cTimbangan.text.replaceAll('.', ''),
        "karung": cKarung.text,
        "KA": cKA.text,
        "HA": cHA.text,
        "Kampas": kampas.value,
        "Berat": berat.value,
        "Tara": tara.value,
        "kompensasi_tara": kompensasiTara.value,
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

  Future cancel(id) async {
    await Rest().getR('datatimbang/$id/cancel');
    Get.to(() => const HomePage());
  }

  static Future updateStandar(harga) async {
    var response = await Rest().postR('harga/${stdData.value.id}', harga);
    stdData.value = StandardData.fromJson(response);

    Get.back();
  }

  static Future getDataTimbang(String tglAwal, String tglAkhir) async {
    var pabrik = storage.box.read('pabrik');

    var response = await Rest().postR('listtimbangan/${pabrik['id']}',
        {"tanggal_awal": tglAwal, "tanggal_akhir": tglAkhir});
    List daftar = response['timbangan'];

    // int totalNetto = 0, totalBayar = 0;
    List<DataTimbang> daftarTimbang = daftar.map((e) {
      return DataTimbang.fromJson(e as Map<String, dynamic>);
    }).toList();
    // totalNetto = int.parse(response['totalNetto'].toString());
    // totalBayar = int.parse(response['totalBayar'].toString());
    rekap.value = DataRekap.fromJson(response['rekap']);
    // print(totalBayar);
    return daftarTimbang;
  }

  void hitungKampas() {
    int timbangan = cTimbangan.text == ''
        ? 0
        : int.parse(cTimbangan.text.replaceAll('.', ''));
    int karung =
        cKarung.text == '' ? 0 : int.parse(cKarung.text.replaceAll('.', ''));

    // kampas.value = (karung * 1.5).ceil();
    berat.value = timbangan - kampas.value - (karung * 0.5).ceil();
    berat.value = berat < 0 ? 0 : berat.value;
    ongKuli.value = karung * stdData.value.hargaKuli;
    ongKarung.value = karung * stdData.value.hargaKarung;
    ongAngkut.value = timbangan * stdData.value.hargaAngkut;
    // ongAngkut.value = tPotonganAngkut.text == ''
    //     ? 0
    //     : int.parse(tPotonganAngkut.text.replaceAll('.', ''));
    hitungTara();
  }

  void hitungTara() {
    int kA = cKA.text == '' ? 0 : int.parse(cKA.text.replaceAll('.', ''));
    int hA = cHA.text == '' ? 0 : int.parse(cHA.text.replaceAll('.', ''));

    int kaStandard = stdData.value.kA;
    int haStandard = stdData.value.hA;

    tara.value = ((kA - kaStandard) + (hA - haStandard));
    tara.value = tara.value < 0 ? 0 : tara.value;
    netto.value = berat.value -
        ((tara.value - kompensasiTara.value) * berat.value / 100).ceil();
    jmlHrg.value = stdData.value.hargaGabah * netto.value;
    totalHrg.value = stdData.value.hargaGabah * netto.value;
    if (potonganAngkut.value) {
      totalHrg.value = totalHrg.value + ongAngkut.value;
    }
    if (potonganKuli.value) {
      // print(potonganKuli);
      totalHrg.value = totalHrg.value + ongKuli.value;
    }
    if (potonganKarung.value) {
      totalHrg.value = totalHrg.value + ongKarung.value;
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
