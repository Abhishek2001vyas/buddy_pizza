import 'dart:convert';

import 'package:buddy_pizza/view/api/subcategorieslist_api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';

List hot = [];

class hotdeal_api extends GetxController {
  RxBool isloading = false.obs;
  final curstapi = Get.put(Subcategories_api());

  void loader() {
    isloading.value = true;
    update();
  }

  // hotdeals() async {
  //   var shared_preferences = await SharedPreferences.getInstance();
  //   var token = shared_preferences.get("token");
  //   loader();
  //   try {
  //     var res = await http.get(Uri.parse("${base_url}hot_deals_list"),
  //         headers: {"token": token.toString()});
  //     var resData = json.decode(res.body);
  //     if (res.statusCode == 200 &&
  //         resData["result"].toString() == "true".toString()) {
  //       print(resData.toString());
  //       hot.clear();
  //       hot.add(resData["data"]);
  //       isloading.value = false;
  //       return hot;
  //     } else {
  //       isloading.value = false;
  //     }
  //   } catch (e) {}
  // }

 Future hotdeals1() async {
    curstapi.curst();
    curstapi.dips();
    var shared_preferences = await SharedPreferences.getInstance();
    var token = shared_preferences.get("token");
    loader();
    try {
      var res = await http.get(
        Uri.parse("${base_url}dealsList"),
      );
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print(resData.toString());
        hot.clear();
        hot.add(resData["data"]);
        isloading.value = false;
        //return hot;
      } else {
        isloading.value = false;
      }
    } catch (e) {}
  }
}
