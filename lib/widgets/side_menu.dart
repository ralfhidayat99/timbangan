import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';
import '../controllers/theme_controller.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final cNav = Get.put(NavigationController());

    return Obx(() => NavigationRail(
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
              icon: Icon(Icons.money_off),
              label: Text('Menu1'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.list),
              label: Text('Menu2'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.local_shipping),
              label: Text('Menu3'),
            ),
          ],
        ));
  }
}
