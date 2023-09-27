import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/controllers/pelanggan_controller.dart';
import 'package:timbangan/controllers/theme_controller.dart';
import 'package:timbangan/models/datatimbang_model.dart';
import 'package:timbangan/pages/timbangan/components/faktur_screen_big.dart';

import '../../../models/pelanggan_model.dart';
import '../../../utils/formatter.dart';

class TimbanganItem extends StatelessWidget {
  const TimbanganItem({super.key, required this.data});
  final List<DataTimbang> data;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: data.map((e) => dataTimbangTile(e, context)).toList());
  }

  Widget dataTimbangTile(DataTimbang data, context) {
    Pelanggan pelanggan = PelangganController.findById(data.idPelanggan);
    TextStyle numberStyle = const TextStyle(
        fontFamily: 'RobotoCondensed',
        fontSize: 18,
        fontWeight: FontWeight.w500);
    return Card(
      margin: const EdgeInsets.all(1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Ubah radius sesuai keinginan Anda
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (data.canceled) cancelStamp(),
          ListTile(
            tileColor: data.canceled
                ? CustomColors.bgColor.value
                : Theme.of(context).cardColor.withAlpha(1),
            onTap: data.canceled
                ? null
                : () => Get.to(() => FakturScreenBig(
                      data: data,
                      pelanggan: pelanggan,
                    )),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 100,
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  decoration: BoxDecoration(
                      color: CustomColors.highLightColor.value.withAlpha(30),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'No : ${data.notimbang}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
            title: Text(
              pelanggan.nama.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelanggan.alamat),
                Text(data.tanggal),
              ],
            ),
            trailing: SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${formatRupiah(data.netto)} Kg',
                    style: numberStyle,
                  ),
                  const VerticalDivider(),
                  Text(
                    'Rp ${formatRupiah(data.totalHarga)}',
                    style: numberStyle,
                  ),
                ],
              ),
            ),
            isThreeLine: true,
          ),
        ],
      ),
    );
  }

  Widget cancelStamp() {
    return Container(
        width: 120,
        transform: Matrix4.rotationZ(-0.1),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        margin: const EdgeInsets.only(left: 70, top: 25),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 1, color: Colors.red.withAlpha(200))),
        child: Row(
          children: [
            Icon(Icons.cancel, color: Colors.red.withAlpha(150)),
            const Spacer(),
            Text(
              'DIBATALKAN',
              style: TextStyle(color: Colors.red.withAlpha(200)),
            )
          ],
        ));
  }
}
