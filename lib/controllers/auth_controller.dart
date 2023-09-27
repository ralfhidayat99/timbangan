import 'package:get/get.dart';
import 'package:timbangan/auth/login_page.dart';
import 'package:timbangan/home.dart';

import '../utils/Rest.dart';
import '../utils/storage.dart';

class AuthController extends GetxController {
  static RxBool isLoading = false.obs;
  static RxBool showPass = false.obs;
  static RxBool rememberMe = false.obs;

  static DataStorage storage = DataStorage();

  static Future login(username, password) async {
    isLoading.value = true;

    var res = await Rest().postR('login', {
      "username": username,
      "password": password,
    });
    isLoading.value = false;

    if (res['status'] == 200) {
      var user = res['user'];
      var pabrik = res['factory'];

      storage.writeUser(user);
      storage.writePabrik(pabrik);

      Get.to(() => const HomePage());
    } else {
      Get.snackbar('Login failed', res['message']);
    }
  }

  static logout() {
    // DataStorage.box.erase();
    storage.box.erase();
    Get.offAll(() => const LoginPage());
  }
}
