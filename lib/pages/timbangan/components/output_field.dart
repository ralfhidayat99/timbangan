import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/theme_controller.dart';
import '../../../controllers/timbangan_controller.dart';
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
                        resultField(context, 'Kampas',
                            cDataTimbang.kampas.toString(), 'Kg'),
                        const SizedBox(height: 2),
                        resultField(context, 'Berat',
                            cDataTimbang.berat.toString(), 'Kg'),
                        const SizedBox(height: 2),
                        resultField(
                            context, 'Tara', cDataTimbang.tara.toString(), '%'),
                        const SizedBox(height: 2),
                        resultField(context, 'Netto',
                            cDataTimbang.netto.toString(), 'Kg'),
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
                                    Text('Ongkos Kuli : ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          cDataTimbang.formatRupiah(
                                              cDataTimbang.jmlHrg.value),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                      Text(
                                          cDataTimbang.formatRupiah(
                                              cDataTimbang.ongKuli.value),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
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
                                      cDataTimbang.formatRupiah(
                                          cDataTimbang.totalHrg.value),
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
