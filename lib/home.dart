import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/widgets/side_drawer.dart';

import 'controllers/navigation_controller.dart';
import 'controllers/theme_controller.dart';
import 'widgets/side_menu.dart';
import 'widgets/titlebar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cNav = Get.put(NavigationController());

    return Obx(
      () => Scaffold(
          backgroundColor: CustomColors.titleBarColor.value,
          endDrawer: const SideDrawer(),
          body: Column(
            children: [
              // ignore: prefer_const_constructors
              TitleBar(),
              Expanded(
                child: Row(
                  children: [
                    const SideMenu(),
                    Obx(() => Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).dividerColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15))),
                          padding: const EdgeInsets.only(top: 1.5, left: 1.5),
                          child: AnimatedSwitcher(
                            duration: 400.milliseconds,
                            transitionBuilder: (child, animation) {
                              const begin = Offset(0.0, 0.2);
                              const end = Offset.zero;
                              const curve = Curves.fastEaseInToSlowEaseOut;
                              final tween = Tween(begin: begin, end: end);
                              final curvedAnimation = CurvedAnimation(
                                  parent: animation, curve: curve);
                              return SlideTransition(
                                position: tween.animate(curvedAnimation),
                                child: child,
                              );
                            },
                            child: cNav.page[cNav.selectedIndex.value],
                          ),
                        )))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
