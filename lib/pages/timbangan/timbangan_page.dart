import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/controllers/pelanggan_controller.dart';
import 'package:timbangan/controllers/timbangan_controller.dart';

import '../../controllers/theme_controller.dart';
import 'components/potongan_list.dart';
import 'components/faktur_screen_big.dart';
import 'components/input_fields.dart';
import 'components/output_field.dart';

class TimbanganPage extends StatelessWidget {
  const TimbanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cDataTimbang = Get.put(TimbanganController());

    final GlobalKey<FormState> keyPembeli = GlobalKey<FormState>();
    final GlobalKey<FormState> keyTimbang = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
            color: CustomColors.bgColor.value,
            borderRadius:
                const BorderRadius.only(topLeft: Radius.circular(15))),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            loadingIndicator(cDataTimbang),
            inputFields(context, cDataTimbang, keyTimbang, keyPembeli),
            PotonganList(cTimbangan: cDataTimbang),
            Expanded(child: outPutField(context, cDataTimbang)),
          ],
        ),
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
            onPressed: () async {
              if (PelangganController.selectedPelanggan.value.id == '') {
                if (keyPembeli.currentState!.validate()) {
                  await PelangganController.addCustomer();
                }
              }
              if (keyTimbang.currentState!.validate()) {
                cDataTimbang
                    .createDataTimbang()
                    .then((value) => Get.to(() => FakturScreenBig(
                        data: cDataTimbang.dataTobePrint,
                        pelanggan:
                            PelangganController.selectedPelanggan.value)))
                    .then((value) {
                      cDataTimbang.cTimbangan.clear();
                      cDataTimbang.cKarung.clear();
                      cDataTimbang.cKA.clear();
                      cDataTimbang.cHA.clear();
                      cDataTimbang.tNopol.clear();
                      cDataTimbang.hitungKampas();
                      cDataTimbang.hitungTara();
                      PelangganController.tNama.clear();
                      PelangganController.tAlamat.clear();
                    })
                    .then((value) => cDataTimbang.getInitData())
                    .then((value) {
                      cDataTimbang.kompensasiTara.value = 0;
                      cDataTimbang.kampas.value = 0;
                    });
                // print('proceeed');
              }
            },
            child: cDataTimbang.isProcessing.value
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.save),
          )),
    );
  }

  Widget loadingIndicator(TimbanganController cDataTimbang) {
    return SizedBox(
        height: 5,
        child: Obx(
          () => Visibility(
            visible: cDataTimbang.isGettingData.value,
            child: LinearProgressIndicator(
                color: CustomColors.btnColorSelected.value),
          ),
        ));
  }
}
