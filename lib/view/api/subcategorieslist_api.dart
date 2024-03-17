import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/dashboard/home/order_details.dart';
import '../utils/constant.dart';

List Subcategorieslist = [];
List curstlist = [];
List productlist = [];
List diplist = [];
List sizelist = [];

List sourceist = [];
List veggielist = [];
List meatlist = [];
List topinslist = [];
List<String> wingflavourlist = [];

class Subcategories_api extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    // Subcategories();
    // categories();
    super.onInit();
  }

  RxBool isloading = false.obs;

  void loader() {
    isloading.value = true;
    update();
  }

  RxBool isloading1 = false.obs;

  void loader1() {
    isloading1.value = true;
    update();
  }

  product(categoryId) async {
    curst();
    topins();
    dips();
    loader1();
    var shared_preferences = await SharedPreferences.getInstance();
    var token = shared_preferences.get("token");
    try {
      var res = await http.post(Uri.parse("${base_url}product_list"),
          // headers: {
          //   "token":token.toString()
          // },
          body: {"categoryId": categoryId.toString()});
      productlist.clear();
      sizelist.clear();
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print(resData.toString());
        productlist.add(resData["data"]);
        print("fffii${resData["data"][0]["size_name"]}");
        //sizelist.add(resData["data"]);
        print("fff${productlist.length}");
        isloading1.value = false;
        //return productlist;
      } else {
        isloading1.value = false;
        print("kidhihoiklijlk");
      }
    } catch (e) {}
  }

  product1() async {
    curst();
    topins();
    dips();
    vggie();
    meat();
    source();

    loader1();
    var shared_preferences = await SharedPreferences.getInstance();
    var token = shared_preferences.get("token");
    try {
      var res = await http.get(
        Uri.parse("${base_url}sizeList"),
        headers: {"token": token.toString()},
      );
      print("ppkjij");
      sizelist.clear();
      var resData = json.decode(res.body);
      print(resData);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print("iiiiigopal" + resData.toString());
        sizelist.add(resData["data"]);
        print("fff33${sizelist[0][0]["size"].toString()}");
        isloading1.value = false;
      } else {
        isloading1.value = false;
        print("kidhihoiklijlk");
      }
    } catch (e) {}
  }

  Future wingsfalvourlist() async {
    try {
      var res = await http.get(
        Uri.parse("${base_url}flavour_list"),
      );
      wingflavourlist.clear();
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        for (int i = 0; i != resData["data"].length; i++) {
          wingflavourlist.add(resData["data"][i]["flavour_name"]);
          update();
        }
      } else {}
    } catch (e) {}
  }

  Future curst() async {
    var shared_preferences = await SharedPreferences.getInstance();
    var token = shared_preferences.get("token");
    try {
      var res = await http.get(
        Uri.parse("${base_url}crustList"),
        // headers: {
        //   "token":token.toString()
        // }
      );
      curstlist.clear();
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        curstlist.add(resData["data"]);
      } else {}
    } catch (e) {}
  }

  Future dips() async {
    var shared_preferences = await SharedPreferences.getInstance();
    var token = shared_preferences.get("token");
    try {
      var res = await http.get(
        Uri.parse("${base_url}dipList"),
        // headers: {
        //   "token":token.toString()
        // }
      );
      diplist.clear();
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        diplist.add(resData["data"]);
      } else {}
    } catch (e) {}
  }

   topins() async {
    var shared_preferences = await SharedPreferences.getInstance();
    try {
      var res = await http.get(
        Uri.parse("${base_url}otherTopinsList"),
        // headers: {
        //   "token":token.toString()
        // }
      );
      topinslist.clear();
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        topinslist.add(resData["data"]);
        print('topins');
      } else {}
    } catch (e) {}
  }

  Future source() async {
    var shared_preferences = await SharedPreferences.getInstance();
    var token = shared_preferences.get("token");
    try {
      var res = await http.get(
        Uri.parse("${base_url}soucesList"),
        // headers: {
        //   "token":token.toString()
        // }
      );
      sourceist.clear();
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        sourceist.add(resData["data"]);
        print('source');
      } else {}
    } catch (e) {}
  }

  Future meat() async {
    var shared_preferences = await SharedPreferences.getInstance();
    var token = shared_preferences.get("token");
    try {
      var res = await http.get(
        Uri.parse("${base_url}meatsList"),
        // headers: {
        //   "token":token.toString()
        // }
      );
      meatlist.clear();
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        meatlist.add(resData["data"]);
        print('meat');
      } else {}
    } catch (e) {}
  }

  Future vggie() async {
    var shared_preferences = await SharedPreferences.getInstance();
    var token = shared_preferences.get("token");
    try {
      var res = await http.get(
        Uri.parse("${base_url}veggiesList"),
        // headers: {
        //   "token":token.toString()
        // }
      );
      veggielist.clear();
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        veggielist.add(resData["data"]);
        print('veggies');
      } else {}
    } catch (e) {}
  }

  Future size(productId) async {
    curst();
    dips();
    var shared_preferences = await SharedPreferences.getInstance();
    var token = shared_preferences.get("token");
    try {
      var res = await http.post(Uri.parse("${base_url}sizeList"),
          headers: {"token": token.toString()},
          body: {"productId": productId.toString()});
      sizelist.clear();
      var resData = json.decode(res.body);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        print("gopalji");
        sizelist.add(resData["data"]);
        Get.to(() => OrderDetails());
        print("wdfd" + sizelist[0][0]["size_name"].toString());
      } else {}
    } catch (e) {}
  }
}
