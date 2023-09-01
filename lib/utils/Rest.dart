// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class Rest {
  static String baseUrl = "http://192.168.1.6:8000/api/";
  static var imageUrl = "http://192.168.1.6:8000/images/produk/";

  getR(url) async {
    Dio dio = Dio();
    // dio.options.headers["api_token"] = token;

    try {
      var res = await dio.get(baseUrl + url);

      return res.data;
    } catch (e) {
      Get.snackbar('OOps!!!', 'sepertinya terjadi masalah');
      return e;
    }
  }

  postR(url, data) async {
    Dio dio = Dio();

    try {
      var res = await dio.post(baseUrl + url, data: data);
      return res.data;
    } catch (e) {
      Get.snackbar('OOps!!!', 'sepertinya terjadi masalah');
      // print(e);

      return e;
    }
  }

  deleteR(url) async {
    Dio dio = Dio();

    try {
      var res = await dio.delete(baseUrl + url);
      // print(res.data);
      return res.data;
    } catch (e) {
      Get.snackbar('OOps!!!', 'sepertinya terjadi masalah');

      return e;
    }
  }
}