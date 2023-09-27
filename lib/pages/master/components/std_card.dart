import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/controllers/timbangan_controller.dart';
import 'package:timbangan/utils/formatter.dart';

import '../../../controllers/theme_controller.dart';
import '../../timbangan/components/textfiled.dart';

class StdCard extends StatelessWidget {
  const StdCard(
      {super.key, required this.title, required this.value, required this.std});

  final String title;
  final int value;
  final String std;

  @override
  Widget build(BuildContext context) {
    TextEditingController tec = TextEditingController();
    tec.text = value.toString();

    TextStyle numberStyle = TextStyle(
        fontFamily: 'RobotoCondensed',
        fontSize: 24,
        fontWeight:
            ThemeController.isDark.value ? FontWeight.w500 : FontWeight.bold);
    return ElevatedButton(
      onPressed: () => Get.defaultDialog(
          title: title,
          content: customTextField(tec, title, () {}, true),
          onConfirm: () => TimbanganController.updateStandar(
              {std: tec.text.replaceAll('.', '')})),
      style: ButtonStyle(
          foregroundColor: ThemeController.isDark.value
              ? MaterialStateProperty.all(Colors.white)
              : MaterialStateProperty.all(Colors.black.withAlpha(180)),
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).cardColor)),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .12,
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      formatRupiah(value),
                      style: numberStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 5,
              child: Icon(Icons.edit,
                  color: CustomColors.btnColorSelected.value, size: 14))
        ],
      ),
    );
  }
}
