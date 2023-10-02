import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/pages/pengaturan/setting_page.dart';

import '../controllers/navigation_controller.dart';
import '../controllers/theme_controller.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final cNav = Get.put(NavigationController());

    return Obx(() => Column(
          children: [
            Expanded(
              child: NavigationRail(
                selectedIndex: cNav.selectedIndex.value,
                selectedLabelTextStyle: TextStyle(
                    color: ThemeController.isDark.value
                        ? Colors.blue[100]
                        : Colors.blue[900]),
                selectedIconTheme: IconThemeData(
                    color: ThemeController.isDark.value
                        ? Colors.blue[100]
                        : Colors.blue[900]),
                backgroundColor: CustomColors.titleBarColor.value,
                onDestinationSelected: (int index) {
                  cNav.selectedIndex.value = index;
                },
                labelType: NavigationRailLabelType.selected,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.scale),
                    label: Text('DT'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.list),
                    label: Text('Transaksi'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.dataset),
                    label: Text('Data'),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: 80,
                child: IconButton(
                    onPressed: () => Get.to(() => const SettingPage(),
                        transition: Transition.cupertinoDialog,
                        duration: 300.milliseconds),
                    icon: const Icon(Icons.settings)))
          ],
        ));
  }
}
