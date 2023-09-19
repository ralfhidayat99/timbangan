import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/controllers/pelanggan_controller.dart';

import 'top_customer_item.dart';

class TopCustomerList extends StatelessWidget {
  const TopCustomerList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PelangganController.getTopCust(),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
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
                  ? TopCustomerItem(data: snapshot.data)
                  : const SizedBox());
        });
  }
}
