import 'package:get_storage/get_storage.dart';

class DataStorage {
  final box = GetStorage();

  writeUser(json) {
    box.write('user', {
      'id': json['id'],
      'name': json['name'],
    });
  }

  writePabrik(json) {
    box.write('pabrik', {
      'id': json['id'],
      'name': json['name'],
      'address': json['address'],
      'phone': json['phone'],
    });
  }
}
