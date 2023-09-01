import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../controllers/theme_controller.dart';

Widget customTextField(
    TextEditingController controller, String label, Function callback) {
  return SizedBox(
    height: 40,
    child: TextField(
      controller: controller,
      onChanged: (_) => callback(),
      style: TextStyle(fontSize: 14),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ],
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 12)),
    ),
  );
}

Widget outputField(context, String prefix, String output, String suffix) {
  return Container(
    width: double.infinity,
    height: 50,
    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.highLightColor.value.withAlpha(100),
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5))),
    child: Row(
      children: [
        Container(
          height: double.infinity,
          width: 80,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          // color: CustomColors.cardHeader.value,
          color: CustomColors.highLightColor.value.withAlpha(30),
          child: Center(
              child: Text(
            prefix,
            style: const TextStyle(
                fontFamily: 'Roboto', fontWeight: FontWeight.bold),
          )),
        ),
        Expanded(
            child: Container(
          color: CustomColors.windowBtnArea.value,
          child: Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                output,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.highLightColor.value),
              ),
            ),
          ),
        )),
        Container(
          height: double.infinity,
          width: 30,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          // color: CustomColors.cardHeader.value,
          color: CustomColors.highLightColor.value.withAlpha(30),
          child: Center(
              child: Text(
            suffix,
            style: const TextStyle(
                fontFamily: 'Roboto', fontWeight: FontWeight.bold),
          )),
        ),
      ],
    ),
  );
}
