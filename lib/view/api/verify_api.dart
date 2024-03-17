import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/dashboard/dashboard.dart';
import '../utils/constant.dart';
import '../utils/utils.dart';
import 'homebanner_api.dart';

var newotp;

class verify_api extends GetxController {
  RxBool isloading = false.obs;
  final banner = Get.put(homebanner_api());
  void loader() {
    isloading.value = true;
    update();
  }

  Future verify(userId, otp) async {
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    try {
      var res = await http.post(Uri.parse("${base_url}verify_otp"),
          body: {"userId": userId.toString(), "otp": otp.toString()});
      var resData = json.decode(res.body);
      print(resData);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        shared_preferences.setString(
            "user_id", resData["data"]["userId"].toString());
        shared_preferences.setString(
            "token", resData["data"]["token"].toString());
        shared_preferences.setString(
            "userno", resData["data"]["phone_no"].toString());
        Utils().sendMassage('${resData['msg'].toString()}');
        update();
        print(resData["data"].toString());
        isloading.value = false;
       await banner.loyalty();
        return Get.to(DashboardScreen());
      } else {
        Utils().sendMassage('${resData['msg'].toString()}');
        //print(resData["msg"].toString());
        isloading.value = false;
      }
    } catch (e) {}
  }

  Future resend(countrycode, mobile) async {
    // loader()
    try {
      var res = await http.post(Uri.parse("${base_url}resend_otp"), body: {
        "country_code": countrycode.toString(),
        "phone_no": mobile.toString(),
      });
      var resData = json.decode(res.body);
      print(resData);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['msg'].toString()}');
        newotp = resData["data"]['otp'].toString();
        print("jdjkfvjkdskvljdsn$newotp");
        update();
        print(resData["data"].toString());
        //  isloading.value = false;
        // return Get.to(DashboardScreen());
      } else {
        Utils().sendMassage('${resData['msg'].toString()}');
        //print(resData["msg"].toString());
        //isloading.value = false;
      }
    } catch (e) {}
  }
}
