import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timbangan/home.dart';

import '../utils/Rest.dart';

class AuthController extends GetxController {
  static RxBool isLoading = false.obs;
  static RxBool showPass = false.obs;

  static RxBool rememberMe = false.obs;

  static final box = GetStorage();

  static Future login(username, password) async {
    isLoading.value = true;

    var res = await Rest().postR('login', {
      "username": username,
      "password": password,
    });
    isLoading.value = false;

    if (res['status'] == 200) {
      var data = res['user'];

      box.write('user', {
        'id': data['id'],
        'name': data['name'],
        'factory_id': data['factory_id'],
        'login': true,
      });

      Get.to(() => const HomePage());
    } else {
      Get.snackbar('Login failed', res['message']);
    }
  }
}
