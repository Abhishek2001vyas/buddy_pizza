import 'dart:convert';

import 'package:buddy_pizza/view/api/subcategorieslist_api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';

List sliderimage = [];
List cate = [];
List loyaltypoint = [];

class homebanner_api extends GetxController {
  final falourlistapi = Get.put(Subcategories_api());

  @override
  void onInit() {
    // TODO: implement onInit
    banner();
    categories();
    super.onInit();
  }

  banner() async {
print("ioioioi");
    var shared_preferences = await SharedPreferences.getInstance();
    var token = shared_preferences.get("token");
    try {
      var res = await http.get(Uri.parse("${base_url}banner_list"),
          headers: {"token": token.toString()});
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print(resData.toString());
        sliderimage.clear();
        sliderimage.add(resData["data"]);
        print("fffrrt");
      } else {
        print("kidhihoiklijlk");
      }
    } catch (e) {}
  }

  Future categories() async {
    falourlistapi.wingsfalvourlist();
    var shared_preferences = await SharedPreferences.getInstance();
    var token = shared_preferences.get("token");
    try {
      var res = await http.get(Uri.parse("${base_url}category_list"),
          headers: {"token": token.toString()});
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        cate.clear();
        cate.add(resData["data"]);
      } else {}
    } catch (e) {}
  }

  loyalty() async {
    print("popopo");
    var shared_preferences = await SharedPreferences.getInstance();
    var userId = shared_preferences.get("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}loyalty_points_list"),
          body: {"userId": userId.toString()});
      loyaltypoint.clear();
      //sizelist.clear();
      print("uiuiu ${res.body}");
      var resData = json.decode(res.body);
      print("yuyuyuy$resData");
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print("tttttt"+resData.toString());
        loyaltypoint.add(resData["loyaltyPoints"]);
        print("iiiii$loyaltypoint");
        //return productlist;
      } else {
        print("kidhihoiklijlk");
      }
    } catch (e) {}
  }
}
