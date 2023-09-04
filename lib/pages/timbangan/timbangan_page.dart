import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/controllers/timbangan_controller.dart';
import 'package:timbangan/pages/timbangan/components/faktur_screen_big.dart';

import '../../controllers/theme_controller.dart';
import 'components/textfiled.dart';

class TimbanganPage extends StatelessWidget {
  const TimbanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cDataTimbang = Get.put(TimbanganController());
    TextEditingController tcontroller = TextEditingController();
    TextEditingController tecHarga = TextEditingController();

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
            SizedBox(
                height: 5,
                child: Obx(
                  () => Visibility(
                    visible: cDataTimbang.isGettingData.value,
                    child: LinearProgressIndicator(
                        color: CustomColors.btnColorSelected.value),
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * .45,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: CustomColors.bgColor.value,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15))),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: double.infinity,
                              decoration: headingDecoration(10),
                              child: Row(
                                children: [
                                  Text('Pembeli',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  const Spacer(),
                                  Obx(() => Text(
                                      'No : ' + cDataTimbang.noTimbang.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge)),
                                ],
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                key: GlobalKey(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customTextField(tcontroller, 'Nama', () {}),
                                    const SizedBox(height: 5),
                                    customTextField(
                                        tcontroller, 'Alamat', () {}),
                                    const SizedBox(height: 5),
                                    customTextField(
                                        tcontroller, 'No. Kendaraan', () {}),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: CustomColors.bgColor.value,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(4),
                            decoration: headingDecoration(0),
                            child: Text('Data Timbang',
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                          const Divider(),
                          const SizedBox(height: 4),
                          customTextField(cDataTimbang.cTimbangan, 'Timbangan',
                              cDataTimbang.hitungKampas),
                          const SizedBox(height: 4),
                          customTextField(cDataTimbang.cKarung, 'Karung',
                              cDataTimbang.hitungKampas),
                          const SizedBox(height: 4),
                          customTextField(
                              cDataTimbang.cKA, 'KA', cDataTimbang.hitungTara),
                          const SizedBox(height: 4),
                          customTextField(
                              cDataTimbang.cHA, 'HA', cDataTimbang.hitungTara),
                          const SizedBox(height: 10),
                          OutlinedButton(
                              onPressed: () {
                                tecHarga.text = cDataTimbang.hrgGabahView.value;
                                Get.defaultDialog(
                                  title: 'Harga Gabah',
                                  onConfirm: () => cDataTimbang.updateHarga(
                                      {'harga_gabah': tecHarga.text}),
                                  content:
                                      customTextField(tecHarga, 'Harga', () {}),
                                );
                              },
                              style: ButtonStyle(
                                  foregroundColor: MaterialStatePropertyAll(
                                      CustomColors.highLightColor.value)),
                              child: Row(
                                children: [
                                  Obx(() => Text(
                                      'Harga Gabah : ${cDataTimbang.hrgGabahView}')),
                                  const Spacer(),
                                  const Icon(Icons.edit)
                                ],
                              )),
                          OutlinedButton(
                              onPressed: () {
                                tecHarga.text = cDataTimbang.ongKuliView.value;
                                Get.defaultDialog(
                                  title: 'Ongkos Kuli',
                                  onConfirm: () => cDataTimbang.updateHarga(
                                      {'harga_kuli': tecHarga.text}),
                                  content:
                                      customTextField(tecHarga, 'Harga', () {}),
                                );
                              },
                              style: ButtonStyle(
                                  foregroundColor: MaterialStatePropertyAll(
                                      CustomColors.highLightColor.value)),
                              child: Row(
                                children: [
                                  Obx(() => Text(
                                      'Ongkos Kuli : ${cDataTimbang.ongKuliView}')),
                                  const Spacer(),
                                  const Icon(Icons.edit)
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Expanded(
              child: Container(
                color: CustomColors.bgColor.value,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: CustomColors.highLightColor.value
                                          .withAlpha(20),
                                      border: Border.all(
                                          width: 3,
                                          color:
                                              CustomColors.cardHeader.value)),
                                  padding: const EdgeInsets.all(8),
                                  child: Obx(() => Column(
                                        children: [
                                          outputField(
                                              context,
                                              'Kampas',
                                              cDataTimbang.kampas.toString(),
                                              'Kg'),
                                          const SizedBox(height: 2),
                                          outputField(
                                              context,
                                              'Berat',
                                              cDataTimbang.berat.toString(),
                                              'Kg'),
                                          const SizedBox(height: 2),
                                          outputField(
                                              context,
                                              'Tara',
                                              cDataTimbang.tara.toString(),
                                              '%'),
                                          const SizedBox(height: 2),
                                          outputField(
                                              context,
                                              'Netto',
                                              cDataTimbang.netto.toString(),
                                              'Kg'),
                                        ],
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: CustomColors.highLightColor.value
                                          .withAlpha(20),
                                      border: Border.all(
                                          width: 3,
                                          color:
                                              CustomColors.cardHeader.value)),
                                  padding: const EdgeInsets.all(8),
                                  child: Obx(() => Column(
                                        children: [
                                          outputField(
                                              context,
                                              'Ongkos Kuli',
                                              cDataTimbang.formatRupiah(
                                                  cDataTimbang.ongKuli.value),
                                              '%'),
                                          const SizedBox(height: 2),
                                          outputField(
                                              context,
                                              'Total',
                                              cDataTimbang.formatRupiah(
                                                  cDataTimbang.totalHrg.value),
                                              'Kg'),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () => cDataTimbang.createDataTimbang(),
                        child: Text('test add data'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
            // onPressed: () => cDataTimbang.createDataTimbang(),
            onPressed: () {
              Get.to(() => const FakturScreenBig());
            },
            // child: Icon(Icons.save),\

            // child:  CircularProgressIndicator(color: Colors.white),
            child: cDataTimbang.isProcessing.value
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.save),
          )),
    );
  }

  BoxDecoration headingDecoration(double radius) {
    return BoxDecoration(
        color: CustomColors.bgColor.value,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(radius)));
  }
}
