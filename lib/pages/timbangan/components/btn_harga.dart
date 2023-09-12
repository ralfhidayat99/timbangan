import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/timbangan_controller.dart';
import 'textfiled.dart';

Widget btnHarga(TimbanganController cDataTimbang) {
  TextEditingController tecHarga = TextEditingController();

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          child: OutlinedButton(
              onPressed: () {
                tecHarga.text = cDataTimbang.hrgGabahView.value;
                Get.defaultDialog(
                  title: 'Harga Gabah',
                  onConfirm: () =>
                      cDataTimbang.updateHarga({'harga_gabah': tecHarga.text}),
                  content: customTextField(tecHarga, 'Harga', () {}, true),
                );
              },
              // style: ButtonStyle(
              //     foregroundColor: MaterialStatePropertyAll(
              //         CustomColors.highLightColor.value)),
              child: Row(
                children: [
                  Obx(() => Text('Harga Gabah : ${cDataTimbang.hrgGabahView}')),
                  const Spacer(),
                  const Icon(Icons.edit)
                ],
              )),
        ),
        const SizedBox(
          width: 15,
        ),
        SizedBox(
          width: 200,
          child: OutlinedButton(
              onPressed: () {
                tecHarga.text = cDataTimbang.ongKuliView.value;
                Get.defaultDialog(
                  title: 'Ongkos Kuli',
                  onConfirm: () =>
                      cDataTimbang.updateHarga({'harga_kuli': tecHarga.text}),
                  content: customTextField(tecHarga, 'Harga', () {}, true),
                );
              },
              // style: ButtonStyle(
              //     foregroundColor: MaterialStatePropertyAll(
              //         CustomColors.highLightColor.value)),
              child: Row(
                children: [
                  Obx(() => Text('Ongkos Kuli : ${cDataTimbang.ongKuliView}')),
                  const Spacer(),
                  const Icon(Icons.edit)
                ],
              )),
        )
      ],
    ),
  );
}
