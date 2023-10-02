import 'package:get/get.dart';

import '../utils/Rest.dart';
import '../utils/storage.dart';

class SettingController extends GetxController {
  RxString facName = ''.obs;
  RxString facAddress = ''.obs;
  RxString facPhone = ''.obs;

  static DataStorage storage = DataStorage();

  @override
  void onInit() {
    var pabrik = storage.box.read('pabrik');
    facName.value = pabrik['name'];
    facAddress.value = pabrik['address'];
    facPhone.value = pabrik['phone'];
    debounce(facName, (callback) => upadateFactory(), time: 500.milliseconds);
    debounce(facAddress, (callback) => upadateFactory(),
        time: 500.milliseconds);
    debounce(facPhone, (callback) => upadateFactory(), time: 500.milliseconds);
    super.onInit();
  }

  upadateFactory() async {
    var pabrik = storage.box.read('pabrik');

    var res = await Rest().putR('factories/${pabrik['id']}', {
      "name": facName.value,
      "address": facAddress.value,
      "phone": facPhone.value,
    });
    storage.writePabrik(res);
  }
}
