import 'package:get/get.dart';

import '../pages/daftar/daftar_timbang.dart';
import '../pages/master/master_page.dart';
import '../pages/timbangan/timbangan_page.dart';

class NavigationController extends GetxController {
  RxInt selectedIndex = 0.obs;

  List page = [
    const TimbanganPage(),
    const DaftarTimbangan(),
    const MasterPage()
  ];
}
