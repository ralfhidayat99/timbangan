import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/theme_controller.dart';
import '../../../controllers/timbangan_controller.dart';

class PotonganList extends StatelessWidget {
  const PotonganList({super.key, required this.cTimbangan});
  final TimbanganController cTimbangan;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(alignment: Alignment.center, children: [
          const Divider(),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: CustomColors.bgColor.value,
              child: const Text('Potongan'))
        ]),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            myCheckBoxTile(context, 'Angkut',
                TimbanganController.potonganAngkut, cTimbangan),
            const SizedBox(width: 10),
            myCheckBoxTile(
                context, 'Kuli', TimbanganController.potonganKuli, cTimbangan),
            const SizedBox(width: 10),
            myCheckBoxTile(context, 'Karung',
                TimbanganController.potonganKarung, cTimbangan),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}

Widget myCheckBoxTile(
    context, String title, RxBool isChecked, TimbanganController cTimbangan) {
  return ElevatedButton(
    onPressed: () {
      isChecked.value = !isChecked.value;
      cTimbangan.hitungTara();
    },
    style: ButtonStyle(
        foregroundColor: ThemeController.isDark.value
            ? MaterialStateProperty.all(Colors.white)
            : MaterialStateProperty.all(Colors.black.withAlpha(180)),
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).cardColor)),
    child: Stack(
      alignment: Alignment.centerRight,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .1,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
        Positioned(
          left: -15,
          child: Obx(() => Checkbox(
                checkColor: Colors.white,
                // fillColor: MaterialStateProperty.resolveWith(getColor),
                shape: const CircleBorder(),
                value: isChecked.value,
                onChanged: (bool? value) {
                  isChecked.value = value!;
                  cTimbangan.hitungTara();
                },
              )),
        )
      ],
    ),
  );
}
