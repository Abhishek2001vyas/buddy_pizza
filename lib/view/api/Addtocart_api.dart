import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../controller.dart';
import '../screen/dashboard/add_cart.dart';
import '../utils/constant.dart';
import '../utils/utils.dart';

class Addtocart_api extends GetxController {
  RxBool isloading = false.obs;
  var totalcartprice = 0.obs;
  RxList cartlist = [].obs;
  final counter = Get.put(PizzaController());

  void loader() {
    isloading.value = true;
    update();
  }

  void adddd(price) {
    totalcartprice.value + price;
  }

  void subdd(price) {
    totalcartprice.value - price;
  }

  Future Addtocart(product) async {
    print("aaaa" + product.toString());
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var request = await http.post(Uri.parse("${base_url}addCart"), body: {
        "userId": user_id.toString(),
        'productId': product.elementAt(0)["productId"].toString(),
        "product_name": product.elementAt(0)["product_name"] ?? "",
        //"order_quantity":product[0]["order_quantity"].toString(),
        "product_size": product[0]["product_size"] ?? "",
        "product_price": product.elementAt(0)["product_price"] ?? "",
        "crust_name": product[0]["crust_name"] ?? "",
        "crust_price": product.elementAt(0)["crust_price"] ?? "",
        // "topings_name": product[0]["dips_name"] ?? "",
        // "topings_price": product.elementAt(0)["dips_price"] ?? "",
        "cart_price": product.elementAt(0)["cart_price"].toString() ?? "",
        "image": product.elementAt(0)["image"] ?? "",
        "topings_name":product.elementAt(0)["topings_name"].toString(),

      });
      print(request.statusCode);
      var resData = json.decode(request.body);
      print("ttt" + resData.toString());
      if (request.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['message'].toString()}');
        loader();
        print(resData["data"].toString());
        counter.uuu(0);
        isloading.value = false;
        Get.to(CartScreen());
      } else {
        Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future Addtocartfordessert(product) async {
    print("aaaa" + product.toString());
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var request = await http.post(Uri.parse("${base_url}addCart"), body: {
        "userId": user_id.toString(),
        'productId': product.elementAt(0)["productId"].toString(),
        "product_name": product.elementAt(0)["product_name"] ?? "",
        "order_quantity": product[0]["order_quantity"].toString(),
        "product_size": product[0]["product_size"] ?? "",
        "product_price": product.elementAt(0)["product_price"] ?? "",
        "crust_name": product[0]["crust_name"] ?? "",
        "crust_price": product.elementAt(0)["crust_price"] ?? "",
        "dips_name": product[0]["dips_name"] ?? "",
        "dips_price": product.elementAt(0)["dips_price"] ?? "",
        "cart_price": product.elementAt(0)["cart_price"].toString() ?? "",
        "image": product.elementAt(0)["image"] ?? ""
      });
      print(request.statusCode);
      var resData = json.decode(request.body);
      print("ttt" + resData.toString());
      if (request.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['message'].toString()}');
        loader();
        print(resData["data"].toString());
        counter.uuu(0);
        Get.to(CartScreen());
        isloading.value = false;
      } else {
        Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future Addtocartforberverage(product) async {
    print("aaaa" + product.toString());
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}addCart"), body: {
        "userId": user_id.toString(),
        'productId': product.elementAt(0)["productId"].toString(),
        "product_name": product.elementAt(0)["product_name"].toString() ?? "",
        "beverages_quantity": product.elementAt(0)["product_name"].toString(),
        "beverages_price": product.elementAt(0)["product_name"].toString(),
        "image": product.elementAt(0)["image"] ?? "",
      "cart_price": product.elementAt(0)["cart_price"].toString() ?? "",
        //"order_quantity": product.elementAt(0)["order_quantity"].toString(),
      });
      print("pp${res.body}");
      var resData = json.decode(res.body);
      print("ttt" + resData.toString());
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['message'].toString()}');
        loader();
        print(resData["data"].toString());
        counter.uuu(0);
        Get.to(CartScreen());
        isloading.value = false;
      } else {
        Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future Addtocartforwings(product) async {
    print("aaaa" + product.toString());
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}addCart"), body: {
        "userId": user_id.toString(),
        'productId': product.elementAt(0)["productId"].toString(),
        "product_name": product.elementAt(0)["product_name"].toString() ?? "",
         "image": product.elementAt(0)["image"] ?? "",
        "flavour":product.elementAt(0)["flavour"] ?? "",
      "cart_price": product.elementAt(0)["cart_price"].toString() ?? "",
        //"order_quantity": product.elementAt(0)["order_quantity"].toString(),
      });
      print("pp${res.body}");
      var resData = json.decode(res.body);
      print("ttt" + resData.toString());
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['message'].toString()}');
        loader();
        print(resData["data"].toString());
        counter.uuu(0);
        Get.to(CartScreen());
        isloading.value = false;
      } else {
        Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future Addtocartforcreateown(product) async {
    //print("arun node1" + product.elementAt(0)["topings_name"][0].runtimeType.toString());

    print("arun node" + product.toString());
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}addCart"), body: {
        "userId": user_id.toString(),
        "product_name": product.elementAt(0)["product_name"].toString() ?? "",
        "product_size": product[0]["product_size"] ?? "",
        "product_price": product.elementAt(0)["product_price"] ?? "",
        "crust_name": product[0]["crust_name"] ?? "",
        "crust_price": product.elementAt(0)["crust_price"] ?? "",
        "image":  "download (5).jpg",
        "cart_price": product.elementAt(0)["cart_price"].toString() ?? "",
        "meats_name":product.elementAt(0)["meats_name"].toString(),
        "meats_price":product.elementAt(0)["meats_price"].toString(),
        "dips_name":product.elementAt(0)["dips_name"].toString(),
        "dips_price": product.elementAt(0)["dips_price"].toString(),
        "souce_name":product.elementAt(0)["souce_name"].toString(),
        "souce_price":product.elementAt(0)["souce_price"].toString(),
        "veggies_name":product.elementAt(0)["veggies_name"].toString(),
        "veggies_price":product.elementAt(0)["veggies_price"].toString(),
        "topings_name":product.elementAt(0)["topings_name"].toString(),

        //"order_quantity": product.elementAt(0)["order_quantity"].toString(),
      });
      print("pp${res.body}");
      var resData = json.decode(res.body);
      print("ttt" + resData.toString());
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['message'].toString()}');
        loader();
        print(resData["data"].toString());
        counter.uuu(0);
        Get.to(CartScreen());
        isloading.value = false;
      } else {
        Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future Addtocartforcombo(product) async {
    print("aaaa" + product.toString());
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}addCart"), body: {
        "userId": user_id.toString(),
        'productId': product.elementAt(0)["productId"].toString(),
        "product_name": product.elementAt(0)["product_name"].toString() ?? "",
        "product_price": product.elementAt(0)["product_price"] ?? "",
        "image": product.elementAt(0)["image"] ?? "",
        "cart_price": product.elementAt(0)["cart_price"].toString() ?? "",
      });
      print("pp${res.body}");
      var resData = json.decode(res.body);
      print("ttt" + resData.toString());
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['message'].toString()}');
        loader();
        print(resData["data"].toString());
        counter.uuu(0);
        Get.to(CartScreen());
        isloading.value = false;
      } else {
        Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  /*Addtocartlist*/

   Addtocartist() async {
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}cartlist"), body: {
        "userId": user_id.toString(),
      });
      totalcartprice.value = 0;
      print("pp${res.body}");
      var resData = json.decode(res.body);
      print("ttt" + resData.toString());
      cartlist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        loader();
        print(resData["data"].toString());
        cartlist.add(resData["data"]);
        print("sssssss" + cartlist[0][0]["products"].length.toString());
        for (int i = 0; i <= cartlist[0][0]["products"].length; i++) {
          print("tttttttttt" +
              cartlist[0][0]["products"][i]["cart_price"]
                  .runtimeType
                  .toString());
          totalcartprice += cartlist[0][0]["products"][i]["cart_price"].round().toInt() ?? 0;
        }

        isloading.value = false;
      } else {
        //Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error2: $e");
    }
  }

  Future Addtocartistupadateadd(currprice, cardid, quantity, cartprice) async {
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    var newcartprice1 = cartprice / currprice;
    var newcartprice2 = newcartprice1 * quantity;
    try {
      var res = await http.post(Uri.parse("${base_url}updateCart"), body: {
        "userId": user_id.toString(),
        "cartId": cardid.toString(),
        "order_quantity": quantity.toString(),
        "cart_price": newcartprice2.toString()
      });
      totalcartprice.value = 0;
      print("pp${res.body}");
      var resData = json.decode(res.body);
      print("ttt" + resData.toString());
      // cartlist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['message'].toString()}');
        loader();
        Addtocartist();
        isloading.value = false;
      } else {
        Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future Addtocartistupadatesub(currprice, cardid, quantity, cartprice) async {
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    var newcartprice1 = cartprice / currprice;
    var newcartprice2 = newcartprice1 * quantity;
    print("iiiiii" + newcartprice2.toString());
    try {
      var res = await http.post(Uri.parse("${base_url}updateCart"), body: {
        "userId": user_id.toString(),
        "cartId": cardid.toString(),
        "order_quantity": quantity.toString(),
        "cart_price": newcartprice2.toString()
      });
      totalcartprice.value = 0;
      print("pp${res.body}");
      var resData = json.decode(res.body);
      print("ttt" + resData.toString());
      // cartlist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['message'].toString()}');
        loader();
        Addtocartist();
        isloading.value = false;
      } else {
        Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future Addtocartistdelete(cardid) async {
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}deleteCart"),
          body: {
        "userId": user_id,
            "cartId": cardid.toString()});
      // totalcartprice.value=0;
      print("pprewq${res.body}");
      var resData = json.decode(res.body);
      print("tttrewq" + resData.toString());
      //cartlist.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        await Addtocartist();
        Utils().sendMassage('${resData['message'].toString()}');
        loader();
        print(resData["data"].toString());

        isloading.value = false;
      } else {
        Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

}
