import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timbangan/controllers/timbangan_controller.dart';

import '../../../controllers/theme_controller.dart';
import '../../../utils/formatter.dart';

Widget customTextField(TextEditingController controller, String label,
    Function callback, bool numberOnly) {
  return Container(
    color: CustomColors.windowBtnArea.value,
    height: 45,
    child: TextFormField(
      controller: controller,
      onChanged: (value) {
        final numericValue = int.tryParse(value.replaceAll('.', ''));
        if (numericValue != null) {
          final formattedValue = formatRupiah(numericValue);
          controller.value = TextEditingValue(
            text: formattedValue,
            selection: TextSelection.collapsed(offset: formattedValue.length),
          );
        }
        callback();
      },
      style: const TextStyle(fontSize: 14),
      inputFormatters: numberOnly
          ? [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ]
          : [],
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          errorStyle: const TextStyle(fontSize: 9, height: 0.1),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 12)),
      validator: (value) {
        if (value!.isEmpty) {
          return '$label harus diisi';
        }
        return null;
      },
    ),
  );
}

Widget resultField(
    context, String prefix, String output, String suffix, Function callback) {
  return Container(
    width: double.infinity,
    height: 50,
    margin: const EdgeInsets.symmetric(vertical: 2),
    decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.highLightColor.value.withAlpha(30),
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
            child: ElevatedButton(
          // color: CustomColors.windowBtnArea.value,
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(CustomColors.windowBtnArea.value)),
          onPressed: () => callback(),
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

Widget inputKampas(context, TimbanganController cDataTimbang) {
  return Container(
    width: double.infinity,
    height: 50,
    margin: const EdgeInsets.symmetric(vertical: 2),
    decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.highLightColor.value.withAlpha(30),
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5))),
    child: Row(
      children: [
        Container(
          height: double.infinity,
          width: 80,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          color: CustomColors.highLightColor.value.withAlpha(30),
          child: const Center(
              child: Text(
            'Kampas',
            style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
          )),
        ),
        Expanded(
            child: Container(
                color: CustomColors.windowBtnArea.value,
                height: 50,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  onChanged: (value) {
                    value = value == '' ? '0' : value;

                    cDataTimbang.kampas.value = int.parse(value);
                    cDataTimbang.hitungKampas();
                  },
                ))),
        // Expanded(
        //     child: Container(
        //   color: CustomColors.windowBtnArea.value,
        //   child: Center(
        //     child: FittedBox(fit: BoxFit.fitWidth, child: TextField()),
        //   ),
        // )),
        Container(
          height: double.infinity,
          width: 30,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          // color: CustomColors.cardHeader.value,
          color: CustomColors.highLightColor.value.withAlpha(30),
          child: const Center(
              child: Text(
            'kg',
            style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
          )),
        ),
      ],
    ),
  );
}
