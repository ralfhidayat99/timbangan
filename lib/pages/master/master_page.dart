import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/pages/master/components/std_card.dart';
import 'package:timbangan/pages/master/components/top_customer_list.dart';
import 'package:timbangan/widgets/wraper.dart';

import '../../controllers/timbangan_controller.dart';

class MasterPage extends StatelessWidget {
  const MasterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      tittle: Text('Master', style: Theme.of(context).textTheme.titleLarge),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StdCard(
                      title: 'Kadar Air',
                      value: TimbanganController.stdData.value.kA,
                      std: 'KA'),
                  StdCard(
                      title: 'Hampa',
                      value: TimbanganController.stdData.value.hA,
                      std: 'HA'),
                  StdCard(
                      title: 'Harga Gabah',
                      value: TimbanganController.stdData.value.hargaGabah,
                      std: 'harga_gabah'),
                  StdCard(
                      title: 'Harga Kuli',
                      value: TimbanganController.stdData.value.hargaKuli,
                      std: 'harga_kuli'),
                  StdCard(
                      title: 'Harga Karung',
                      value: TimbanganController.stdData.value.hargaKarung,
                      std: 'harga_karung'),
                ],
              )),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => print(TimbanganController.stdData.value.hargaGabah),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  'Penjual Terbanyak',
                  style: Theme.of(context).textTheme.titleLarge,
                )),
          ),
          TopCustomerList()
        ],
      ),
    );
  }
}
