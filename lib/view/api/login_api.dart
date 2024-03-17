import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/otp_screen.dart';
import '../utils/constant.dart';
import '../utils/utils.dart';

class signIn_api extends GetxController {
  RxBool isloading = false.obs;

  void loader() {
    isloading.value = true;
    update();
  }

  Future signIn(mobile, countrycode) async {
    //  print("$mobile $countrycode");
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    try {
      var res = await http.post(Uri.parse("${base_url}user_login"), body: {
        "country_code": countrycode.toString(),
        "phone_no": mobile.toString(),
      });
      var resData = json.decode(res.body);
      print(resData);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        // shared_preferences.setString(
        //     "user_id", resData["data"]["_id"].toString());
        Utils().sendMassage('${resData['msg'].toString()}');
        update();
        // print(resData["data"].toString());
        isloading.value = false;
        return Get.to(OtpScreen(
          userid: resData["data"]["userId"].toString(),
          otp: resData["data"]["otp"].toString(),
          countrycode: countrycode.toString(),
          mobileno: mobile.toString(),
        ));
      } else {
        Utils().sendMassage('${resData['msg'].toString()}');
        isloading.value = false;
      }
    } catch (e) {}
  }
}
