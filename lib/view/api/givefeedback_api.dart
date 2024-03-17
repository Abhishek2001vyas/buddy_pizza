import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';
import '../utils/utils.dart';

class givefeedback_api extends GetxController {
  RxBool isloading = false.obs;
  RxBool isloading1 = false.obs;

  void loader() {
    isloading.value = true;
    update();
  }

  void loader1() {
    isloading1.value = true;
    update();
  }

  Future feedback(text) async {
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var userId = shared_preferences.get("user_id");
    var token = shared_preferences.get("token");
    print("nnnklnkl$token");
    try {
      var res =
          await http.post(Uri.parse("${base_url}give_feedback"), headers: {
        "token": token.toString()
      }, body: {
        "text": text.toString(),
        "userId": userId.toString(),
      });
      var resData = json.decode(res.body);
      print(resData);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['msg'].toString()}');
        update();
        print(resData.toString());
        isloading.value = false;
        // return
      } else {
        Utils().sendMassage('${resData['msg'].toString()}');
        isloading.value = false;
      }
    } catch (e) {}
  }

  Future rating(rating) async {
    loader1();
    var shared_preferences = await SharedPreferences.getInstance();
    var userId = shared_preferences.get("user_id");
    var token = shared_preferences.get("token");
    try {
      var res = await http.post(Uri.parse("${base_url}give_rating"), headers: {
        "token": token.toString()
      }, body: {
        "rating": rating.toString(),
        "userId": userId.toString(),
      });
      var resData = json.decode(res.body);
      // print(resData);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['msg'].toString()}');
        update();
        // print(resData.toString());
        isloading1.value = false;
        // return
      } else {
        Utils().sendMassage('${resData['msg'].toString()}');
        isloading1.value = false;
      }
    } catch (e) {}
  }

// Future terms() async {
//   loader();
//   var shared_preferences = await SharedPreferences.getInstance();
//   var userId=shared_preferences.get("user_id");
//   var token=shared_preferences.get("token");
//   print("nnnklnkl$token");
//   try {
//     var res =
//
//     await http.post(Uri.parse("${base_url}give_feedback"),
//         headers: {
//           "token":token.toString()
//         },
//         body: {
//           "text":text.toString(),
//           "userId":userId.toString(),
//         });
//     var resData = json.decode(res.body);
//     print(resData);
//     if (res.statusCode == 200 &&
//         resData["result"].toString() == "true".toString()) {
//
//       Utils().sendMassage('${resData['msg'].toString()}');
//       update();
//       print(resData.toString());
//       isloading.value = false;
//       // return
//     } else {
//       Utils().sendMassage('${resData['msg'].toString()}');
//       isloading.value = false;
//     }
//   } catch (e) {}
// }
//
// Future ploicy() async {
//   loader();
//   var shared_preferences = await SharedPreferences.getInstance();
//   var userId=shared_preferences.get("user_id");
//   var token=shared_preferences.get("token");
//   print("nnnklnkl$token");
//   try {
//     var res =
//
//     await http.post(Uri.parse("${base_url}privacy_policy"),
//         headers: {
//           "token":token.toString()
//         },
//         body: {
//           "text":text.toString(),
//           "userId":userId.toString(),
//         }
//         );
//     var resData = json.decode(res.body);
//     print(resData);
//     if (res.statusCode == 200 &&
//         resData["result"].toString() == "true".toString()) {
//
//       Utils().sendMassage('${resData['msg'].toString()}');
//       update();
//       print(resData.toString());
//       isloading.value = false;
//       // return
//     } else {
//       Utils().sendMassage('${resData['msg'].toString()}');
//       isloading.value = false;
//     }
//   } catch (e) {}
// }
}
