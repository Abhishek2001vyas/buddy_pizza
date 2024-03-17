import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';

List terms_condition_list = [];
List privacy_policy_list = [];

class termscondition_api extends GetxController {
  Future terms_condition() async {
    var shared_preferences = await SharedPreferences.getInstance();
    var token = shared_preferences.get("token");
    try {
      var res = await http.get(Uri.parse("${base_url}terms_and_condition"),
          headers: {"token": token.toString()});
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        terms_condition_list.clear();
        terms_condition_list.add(resData["data"][0]);
      } else {}
    } catch (e) {}
  }

  Future privacy_policy() async {
    var shared_preferences = await SharedPreferences.getInstance();
    var token = shared_preferences.get("token");
    try {
      var res = await http.get(Uri.parse("${base_url}privacy_policy"),
          headers: {"token": token.toString()});
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        privacy_policy_list.clear();
        privacy_policy_list.add(resData["data"][0]);
      } else {}
    } catch (e) {}
  }
}
