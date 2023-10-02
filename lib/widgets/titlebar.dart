import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/theme_controller.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
          padding: const EdgeInsets.only(left: 10),
          height: 40,
          color: CustomColors.titleBarColor.value,
          // color: ThemeController.isDark.value
          //     ? ThemeController.titleBarDark.value
          //     : ThemeController.titleBarLight.value,
          child: WindowTitleBarBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MoveWindow(child: const FlutterLogo(size: 20)),
                const Text(' Digital DT'),
                // const Spacer(),
                Expanded(child: MoveWindow()),
                WindowButton(
                    // onPressed: () => ThemeController.isDark.value
                    //     ? cTheme.ligthTheme()
                    //     : cTheme.darkTheme(),
                    colors: buttonColorsLight,
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    iconBuilder: (buttonContext) => Transform.translate(
                          offset: const Offset(0, -7),
                          child: const Icon(Icons.palette),
                          // child: ThemeController.isDark.value
                          //     ? const Icon(Icons.light_mode)
                          //     : const Icon(Icons.dark_mode)
                        )),
                // ignore: prefer_const_constructors
                WindowButtons(),
              ],
            ),
          )),
    );
  }
}

final buttonColorsLight = WindowButtonColors(
    iconNormal: Colors.black,
    mouseOver: Colors.blueGrey,
    mouseDown: Colors.white24,
    iconMouseOver: Colors.black,
    iconMouseDown: Colors.black);

final buttonColorsDark = WindowButtonColors(
    iconNormal: Colors.white,
    mouseOver: Colors.grey,
    mouseDown: Colors.grey[800],
    iconMouseOver: Colors.white,
    iconMouseDown: Colors.grey);

// final buttonColorsDark = WindowButtonColors(
//     iconNormal: ThemeController.isDark.value
//         ? Colors.white
//         : Color.fromARGB(255, 62, 87, 88),
//     mouseOver: const Color.fromARGB(255, 248, 240, 225),
//     mouseDown: const Color.fromARGB(255, 6, 128, 6),
//     iconMouseOver: const Color.fromARGB(255, 62, 9, 255),
//     iconMouseDown: const Color.fromARGB(255, 175, 175, 173));

final lightCloseButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color.fromARGB(255, 62, 87, 88),
    iconMouseOver: Colors.white);
final darkCloseButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: Colors.white,
    iconMouseOver: Colors.white);

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  WindowButtonsState createState() => WindowButtonsState();
}

class WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: CustomColors.windowBtnArea.value,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          MinimizeWindowButton(
              colors: ThemeController.isDark.value
                  ? buttonColorsDark
                  : buttonColorsLight,
              animate: true),
          appWindow.isMaximized
              ? RestoreWindowButton(
                  colors: ThemeController.isDark.value
                      ? buttonColorsDark
                      : buttonColorsLight,
                  onPressed: maximizeOrRestore,
                )
              : MaximizeWindowButton(
                  colors: ThemeController.isDark.value
                      ? buttonColorsDark
                      : buttonColorsLight,
                  onPressed: maximizeOrRestore,
                ),
          CloseWindowButton(
            colors: ThemeController.isDark.value
                ? darkCloseButtonColors
                : lightCloseButtonColors,
          )
        ],
      ),
    );
  }
}
