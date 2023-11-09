import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:window_manager/window_manager.dart';

import 'auth/login_page.dart';
import 'controllers/theme_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
        size: Size(800, 700),
        backgroundColor: Colors.white,
        center: true,
        skipTaskbar: false,
        title: "Digital DT",
        titleBarStyle: TitleBarStyle.hidden,
        windowButtonVisibility: false);
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final cTheme = Get.put(ThemeController());

    // var data = box.read('dataMaster');
    if (box.read('theme') == 'dark') {
      cTheme.darkTheme();
    } else {
      cTheme.ligthTheme();
    }
    return GetMaterialApp(
      title: 'Digital DT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      // home: const HomePage(),
      home: const LoginPage(),
    );
  }
}
