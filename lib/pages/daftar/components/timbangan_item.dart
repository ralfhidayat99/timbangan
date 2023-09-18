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
    TextStyle numberStyle = TextStyle(
        fontFamily: 'RobotoCondensed',
        fontSize: 18,
        fontWeight: FontWeight.w500);
    Pelanggan pelanggan = PelangganController.findById(data.idPembeli);
    return Card(
      elevation: 2,
      child: ListTile(
        onTap: () => Get.to(() => FakturScreenBig(
              data: data,
              pelanggan: pelanggan,
            )),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              decoration: BoxDecoration(
                  color: CustomColors.highLightColor.value.withAlpha(30),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'No : ${data.notimbang}',
                    style: TextStyle(fontWeight: FontWeight.w600),
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
              VerticalDivider(),
              Text(
                'Rp ${formatRupiah(data.netto * data.harga)}',
                style: numberStyle,
              ),
            ],
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}
