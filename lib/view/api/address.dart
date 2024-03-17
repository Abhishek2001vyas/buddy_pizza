import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/dashboard/dashboard.dart';
import '../screen/dashboard/home/your_order.dart';
import '../utils/constant.dart';
import '../utils/utils.dart';

List Addresslist = [];


class Address_api extends GetxController {
  RxBool isloading = false.obs;
  var deliverychager=0.obs;

  void loader() {
    isloading.value = true;
    update();
  }

  Future Addaddressapi(house_no, floor_no, building_name, how_to_reach,
      contact_no, lat, long, goto) async {
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var request = await http.post(Uri.parse("${base_url}add_address"), body: {
        "userId": user_id.toString(),
        'house_no': house_no.toString(),
        "floor_no": floor_no.toString(),
        "building_name": building_name.toString(),
        "how_to_reach": how_to_reach.toString(),
        "contact_no": contact_no.toString(),
        "lat": lat.toString(),
        "long": long.toString(),
      });
      print(request.statusCode);
      var resData = json.decode(request.body);
      print("ttt" + resData.toString());
      if (request.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['msg'].toString()}');
        loader();
        print(resData["data"].toString());
        isloading.value = false;
        goto == 1 ? Get.to(YourOrder()) : Get.to(DashboardScreen());
      } else {
        Utils().sendMassage('${resData['msg'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future Addresslistapi() async {
    loader();

    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}get_address"), body: {
        "userId": user_id.toString(),
      });

      print("pp${res.body}");
      var resData = json.decode(res.body);
      print("ttt" + resData.toString());
      Addresslist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        loader();
        await deliverylistapi();
        print(resData["data"].toString());
        Addresslist.add(resData["data"]);
        isloading.value = false;
      } else {
        //Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future deliverylistapi() async {
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}delivery_charge"), body: {
        "userId": user_id.toString(),
      });

      print("pp${res.body}");
      var resData = json.decode(res.body);
      print("ttt" + resData.toString());
      deliverychager.value=0;
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        loader();
        //print(resData["data"].toString());

        deliverychager.value=resData["deliveryCharge"];
        isloading.value = false;
      } else {
        //Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
