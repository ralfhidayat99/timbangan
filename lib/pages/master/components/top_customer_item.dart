import 'package:flutter/material.dart';
import 'package:timbangan/controllers/pelanggan_controller.dart';

import '../../../models/pelanggan_model.dart';
import '../../../utils/formatter.dart';

class TopCustomerItem extends StatelessWidget {
  const TopCustomerItem({super.key, required this.data});
  final List data;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: data.map((e) => dataTimbangTile(e, context)).toList());
  }

  Widget dataTimbangTile(data, context) {
    TextStyle numberStyle = const TextStyle(
        fontFamily: 'RobotoCondensed',
        fontSize: 18,
        fontWeight: FontWeight.w500);
    Pelanggan pelanggan =
        PelangganController.findById(data['id_pembeli'].toString());
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Ubah radius sesuai keinginan Anda
      ),
      margin: const EdgeInsets.all(1),
      child: ListTile(
        onTap: () {},
        title: Text(
          pelanggan.nama.toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: Text(
          formatTonase(
            double.parse(data['totalTimbang']),
          ),
          style: numberStyle,
        ),
      ),
    );
  }
}
