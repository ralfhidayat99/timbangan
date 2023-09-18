import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/controllers/timbangan_controller.dart';
import 'package:timbangan/pages/daftar/components/timbangan_item.dart';
import 'package:timbangan/widgets/wraper.dart';

class DaftarTimbangan extends StatelessWidget {
  const DaftarTimbangan({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      tittle: SizedBox(
          width: double.infinity,
          child: Text('Daftar Transaksi',
              style: Theme.of(context).textTheme.titleLarge)),
      content: FutureBuilder(
        future: TimbanganController.getDataTimbang(),
        builder: (context, snapshot) {
          return Column(
            children: [
              AnimatedSwitcher(
                  duration: 500.milliseconds,
                  transitionBuilder: (child, animation) {
                    const begin = Offset(0.0, 0.2);
                    const end = Offset.zero;
                    const curve = Curves.fastLinearToSlowEaseIn;
                    final tween = Tween(begin: begin, end: end);
                    final curvedAnimation =
                        CurvedAnimation(parent: animation, curve: curve);
                    return SlideTransition(
                      position: tween.animate(curvedAnimation),
                      child: child,
                    );
                  },
                  child: snapshot.hasData
                      ? TimbanganItem(data: snapshot.data)
                      : const SizedBox())
            ],
          );
        },
      ),
    );
  }
}
