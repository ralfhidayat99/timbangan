import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/theme_controller.dart';
import '../../../controllers/timbangan_controller.dart';
import '../../../utils/formatter.dart';
import 'textfiled.dart';

Widget outPutField(context, TimbanganController cDataTimbang) {
  return Container(
    color: CustomColors.bgColor.value,
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Obx(() => Column(
                      children: [
                        resultField(
                            context, 'Kampas', cDataTimbang.kampas.value, 'Kg'),
                        const SizedBox(height: 2),
                        resultField(
                            context, 'Berat', cDataTimbang.berat.value, 'Kg'),
                        const SizedBox(height: 2),
                        resultField(
                            context, 'Tara', cDataTimbang.tara.value, '%'),
                        const SizedBox(height: 2),
                        resultField(
                            context, 'Netto', cDataTimbang.netto.value, 'Kg'),
                      ],
                    )),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  elevation: 10,
                  child: DottedBorder(
                    padding: const EdgeInsets.all(18),
                    borderPadding: const EdgeInsets.all(5),
                    strokeWidth: 2,
                    color: CustomColors.highLightColor.value.withAlpha(120),
                    dashPattern: const [10, 2],
                    child: Obx(() => Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Jumlah : ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                    Visibility(
                                      visible: TimbanganController
                                          .potonganKuli.value,
                                      child: Text('Potongan Kuli : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                    ),
                                    Visibility(
                                      visible: TimbanganController
                                          .potonganKarung.value,
                                      child: Text('Potongan Karung : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                    ),
                                    Visibility(
                                      visible: TimbanganController
                                          .potonganAngkut.value,
                                      child: Text('Potongan Angkut : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          formatRupiah(
                                              cDataTimbang.jmlHrg.value),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                      Visibility(
                                        visible: TimbanganController
                                            .potonganKuli.value,
                                        child: Text(
                                            formatRupiah(
                                                cDataTimbang.ongKuli.value),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge),
                                      ),
                                      Visibility(
                                        visible: TimbanganController
                                            .potonganKarung.value,
                                        child: Text(
                                            formatRupiah(
                                                cDataTimbang.ongKarung.value),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge),
                                      ),
                                      Visibility(
                                        visible: TimbanganController
                                            .potonganAngkut.value,
                                        child: SizedBox(
                                          height: 40,
                                          child: TextFormField(
                                            onChanged: (value) {
                                              // Saat teks berubah, format angka dan tampilkan kembali di TextField
                                              final numericValue = int.tryParse(
                                                  value.replaceAll('.', ''));
                                              if (numericValue != null) {
                                                final formattedValue =
                                                    formatRupiah(numericValue);
                                                cDataTimbang.tPotonganAngkut
                                                    .value = TextEditingValue(
                                                  text: formattedValue,
                                                  selection:
                                                      TextSelection.collapsed(
                                                          offset: formattedValue
                                                              .length),
                                                );
                                                cDataTimbang.hitungKampas();
                                              }
                                            },
                                            controller:
                                                cDataTimbang.tPotonganAngkut,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9.]')),
                                            ],
                                            textAlign: TextAlign.end,
                                            autofocus: true,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 0)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 3,
                              color: CustomColors.highLightColor.value
                                  .withAlpha(100),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total : ',
                                    textAlign: TextAlign.end,
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                Expanded(
                                  child: Text(
                                      formatRupiah(cDataTimbang.totalHrg.value),
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
