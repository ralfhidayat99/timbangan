import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum ThemeCode { gelap, terang }

class ThemeController extends GetxController {
  static var isDark = false.obs;
  final box = GetStorage();
  ThemeCode? darkLight;

  static BoxDecoration cornerDecoration = BoxDecoration(
      color: CustomColors.bgColor.value,
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15)));

  ligthTheme() {
    CustomColors.titleBarColor = const Color.fromARGB(255, 233, 246, 248).obs;
    CustomColors.bgColor = const Color.fromARGB(255, 252, 252, 252).obs;
    CustomColors.highLightColor = const Color.fromARGB(255, 0, 0, 0).obs;
    CustomColors.btnColorSelected = const Color.fromARGB(255, 13, 71, 161).obs;
    CustomColors.windowBtnArea = const Color.fromARGB(255, 255, 255, 255).obs;
    CustomColors.cardHeader = const Color.fromARGB(255, 248, 248, 248).obs;
    CustomColors.windowMinimizeArea = const Color.fromARGB(255, 1, 0, 10).obs;
    CustomColors.titleBarColor = const Color.fromARGB(255, 233, 246, 248).obs;

    isDark.value = false;
    box.write('theme', 'light');
    darkLight = ThemeCode.terang;
    Get.changeTheme(ligth());
  }

  darkTheme() {
    CustomColors.bgColor = const Color.fromARGB(255, 29, 30, 31).obs;
    CustomColors.highLightColor = const Color.fromARGB(255, 255, 255, 255).obs;
    CustomColors.btnColorSelected =
        const Color.fromARGB(255, 187, 222, 251).obs;
    CustomColors.windowBtnArea = const Color.fromARGB(255, 66, 66, 66).obs;
    CustomColors.windowMinimizeArea =
        const Color.fromARGB(255, 255, 255, 255).obs;
    CustomColors.cardHeader = const Color.fromARGB(255, 56, 57, 58).obs;
    CustomColors.titleBarColor = const Color.fromARGB(255, 70, 69, 73).obs;

    isDark.value = true;
    box.write('theme', 'dark');
    darkLight = ThemeCode.gelap;

    Get.changeTheme(dark());
  }

  ThemeData ligth() {
    return ThemeData.light().copyWith(
        // cardColor: const Color.fromARGB(255, 228, 235, 238),
        // scaffoldBackgroundColor: const Color.fromARGB(255, 182, 200, 207),
        // textTheme: TextTheme(
        //     titleMedium: TextStyle(fontFamily: 'Roboto', color: Colors.black))
        );
  }

  ThemeData dark() {
    return ThemeData.dark().copyWith(
      cardColor: const Color.fromARGB(255, 43, 45, 47),
      scaffoldBackgroundColor: const Color(0xFF212332),
      // textTheme: TextTheme(titleMedium: TextStyle(fontFamily: 'Roboto'))
      // dividerColor: Colors.white,
    );
  }

  // static Widget judul(String jdl) {
  //   return Padding(
  //       padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
  //       child: Text(jdl,
  //           style: TextStyle(
  //               fontSize: 20,
  //               color: Colors.grey[800],
  //               fontWeight: FontWeight.bold)));
  // }
}

class CustomColors {
  static var titleBarColor = const Color.fromARGB(255, 233, 246, 248).obs,
      sideBarColor = const Color.fromARGB(255, 233, 246, 248).obs,
      bgColor = Color.fromARGB(255, 255, 255, 255).obs,
      bgDarkColor = const Color.fromARGB(255, 0, 0, 0).obs,
      highLightColor = const Color.fromARGB(255, 0, 0, 0).obs,
      btnColorSelected = const Color.fromARGB(255, 13, 71, 161).obs,
      cardHeader = const Color.fromARGB(255, 235, 243, 243).obs,
      windowBtnArea = const Color.fromARGB(255, 255, 255, 255).obs,
      windowMinimizeArea = const Color.fromARGB(255, 1, 0, 10).obs;
}
