// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class Rest {
  // static String baseUrl = "http://192.168.1.6:8000/api/";
  // static String baseUrl = "http://127.0.0.1:8000/api/";
  static String baseUrl = "https://digitaldt.berasratu.com/api/";

  getR(url) async {
    Dio dio = Dio();
    // dio.options.headers["api_token"] = token;

    try {
      var res = await dio.get(baseUrl + url);

      return res.data;
    } catch (e) {
      Get.snackbar('OOps!!!', 'sepertinya terjadi masalah');
      return {'error': true, 'message': e};
    }
  }

  postR(url, data) async {
    Dio dio = Dio();

    try {
      var res = await dio.post(baseUrl + url, data: data);
      // print(res);
      return res.data;
    } catch (e) {
      Get.snackbar('OOps!!!', 'sepertinya terjadi masalah');
      // print(e);

      return e;
    }
  }

  putR(url, data) async {
    Dio dio = Dio();

    try {
      var res = await dio.put(baseUrl + url, data: data);
      // print(res);
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
