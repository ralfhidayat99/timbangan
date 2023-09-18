import 'package:flutter/material.dart';
import 'package:timbangan/utils/formatter.dart';

import '../../../controllers/theme_controller.dart';

class StdCard extends StatelessWidget {
  const StdCard(
      {super.key, required this.title, required this.value, required this.url});

  final String title;
  final int value;
  final String url;

  @override
  Widget build(BuildContext context) {
    TextStyle numberStyle = TextStyle(
        fontFamily: 'RobotoCondensed',
        fontSize: 24,
        fontWeight:
            ThemeController.isDark.value ? FontWeight.w500 : FontWeight.bold);
    return ElevatedButton(
      onPressed: () {},
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
            width: MediaQuery.of(context).size.width * .175,
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
                  padding: const EdgeInsets.only(top: 5.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      formatRupiah(value),
                      style: numberStyle,
                    ),
                  ),
                ),
                const FittedBox(
                    fit: BoxFit.fitWidth, child: Text('Terakhir diedit')),
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
