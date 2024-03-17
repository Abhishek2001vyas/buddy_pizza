import 'dart:convert';
import '../screen/dashboard/profile/profile_details/track_order.dart';
import 'package:buddy_pizza/view/screen/dashboard/dashboard.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/dashboard/home/your_order.dart';
import '../utils/constant.dart';
import '../utils/utils.dart';

List orderlistt = [];
List chargelistt = [];
List applyointlistt = [];
// List applyointlistt = [];
class Orderplaced_api extends GetxController {
  RxBool isloading = false.obs;
  RxList placeorderlistt = [].obs;
  var totalprice=0.obs;
  var taxprice=0.obs;
  var coupenred=[].obs;

  void loader() {
    isloading.value = true;
    update();
  }

  addOrder(
    cartId,
    grand_total,
    total_item,
    note,
  ) async {
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    print("hhhhhreefr${grand_total}");
    try {
      var res = await http.post(Uri.parse("${base_url}addOrder"), body: {
        "userId": user_id,
        "cartId": cartId.toString(),
        "grand_total": grand_total.toString(),
        "total_item": total_item.toString(),
        "note": note
      });
      print(res.body.toString());
      var resData = json.decode(res.body);
      print("iuuuuutre"+resData.toString());
      print(resData);
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
       // Utils().sendMassage('${resData['message'].toString()}');
        update();
        await orderlist();
        print("ppp345");
        applyointlistt.clear();
        isloading.value = false;
        Get.to(() => YourOrder(
              cartId: cartId,
            ));
      } else {
        Utils().sendMassage('${resData['message'].toString()}');
        isloading.value = false;
      }
    } catch (e) {}
  }



  appltpoint(point)async{
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    print("hhhhh33${user_id}");
    try {
      var res = await http.post(Uri.parse("${base_url}apply_loyalty_points"), body: {
        "userId": user_id.toString(),
        "loyaltyPoints":point.toString()
      });
      print(res.toString());
      var resData = json.decode(res.body);
      print("arun333" + resData.toString());
      applyointlistt.clear();
      if (res.statusCode == 400 &&
          resData["result"].toString() == "true".toString()) {
        applyointlistt.add(resData["price"]);
        print("ooooooo${applyointlistt.toString()}");
         Utils().sendMassage('${resData['msg'].toString()}');
        update();
        await chargelist();
        isloading.value = false;
        //Get.to(const YourOrder());
      } else {
        Utils().sendMassage('${resData['msg'].toString()}');
        isloading.value = false;
      }
    } catch (e) {}
  }

  applycoupen(couponId,discount_price)async{
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    print("hhhhh33${user_id}");
    try {
      var res = await http.post(Uri.parse("${base_url}apply_coupen"), body: {
        "userId": user_id.toString(),
        "couponId":couponId.toString(),
        "discount_price":discount_price.toString()
      });
      print(res.toString());
      var resData = json.decode(res.body);
      print("aruncoupen" + resData.toString());
      coupenred.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        coupenred.add(resData["data"]);
        print("ooooooo${coupenred.toString()}");
        Utils().sendMassage('${resData['msg'].toString()}');
        update();
        await chargelist();
        Get.off(const YourOrder());
        isloading.value = false;

      } else {
        Utils().sendMassage('${resData['msg'].toString()}');
        isloading.value = false;
      }
    } catch (e) {}
  }

  deletecoupen(id)async{
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    print("hhhhh33${user_id}");
    try {
      var res = await http.post(Uri.parse("${base_url}delete_applied_coupen"), body: {

        "_id":id.toString()
      });
      print(res.toString());
      var resData = json.decode(res.body);
      print("aruncoupen" + resData.toString());
      coupenred.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
       // coupenred.add(resData["data"]);
       // print("ooooooo${coupenred.toString()}");
        Utils().sendMassage('${resData['msg'].toString()}');
        update();
       // await chargelist();
        isloading.value = false;

      } else {
        Utils().sendMassage('${resData['msg'].toString()}');
        isloading.value = false;
      }
    } catch (e) {}
  }

  orderlist() async {

    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    print("hhhhh${user_id}");
    try {
      var res = await http.post(Uri.parse("${base_url}order_list"), body: {
        "userId": user_id.toString(),
      });
      print(res.toString());
      var resData = json.decode(res.body);
      print("arun1234" + resData.toString());
      orderlistt.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        orderlistt.add(resData["data"]);
        print("ooooooo${orderlistt.toString()}");
      //  Utils().sendMassage('${resData['msg'].toString()}');
        update();
        await chargelist();
        isloading.value = false;
        //Get.to(const YourOrder());
      } else {
        Utils().sendMassage('${resData['msg'].toString()}');
        isloading.value = false;
      }
    } catch (e) {}
  }

  chargelist() async {
    print("pookdk");
   try {
      var res = await http.get(
        Uri.parse("${base_url}charges_list"),
      );
      var resData = json.decode(res.body);
print("ppppjdhf");
      chargelistt.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        chargelistt.add(resData["data"]);
      //  Utils().sendMassage('${resData['msg'].toString()}');
      print('iiiiijknjknbjknhdrfokin${orderlistt .elementAt(0)[ "grand_total"]*(int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100)}');
        taxprice= orderlistt .elementAt(0)[ "grand_total"]*( int.parse(chargelistt[0][0]["tax"].toString().replaceAll("%", ""))/100);
      print("taxprice$taxprice");
        totalprice.value=orderlistt.elementAt(0)["grand_total"]+ taxprice.value;
     print("totalprice$totalprice");
     
      update();
        //Get.to(const YourOrder());
      } else {
       // Utils().sendMassage('${resData['msg'].toString()}');
      }
    } catch (e) {}
  }

  placedorder_api(orderId, status_mode, addressId, delivery_charge,
      reedom_point, coupon, taxes_and_charges, sub_total, total, cartId) async {
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var res = await http.post(Uri.parse("${base_url}place_order"),
          body:
          reedom_point=="0" ?
          {
            "userId": user_id,
            "orderId": orderId.toString(),
            "cartId": cartId,
            "status_mode": status_mode.toString(),
            "address": addressId.toString(),
            "delivery_charge": delivery_charge.toString(),
           // "reedom_point": reedom_point.toString(),
            "coupon": coupon.toString(),
            "taxes_and_charges": taxes_and_charges.toString(),
            "sub_total": sub_total.toString(),
            "total": total.toString(),
          }:
          coupon==0?
          {
            "userId": user_id,
            "orderId": orderId.toString(),
            "cartId": cartId,
            "status_mode": status_mode.toString(),
            "address": addressId.toString(),
            "delivery_charge": delivery_charge.toString(),
            "reedom_point": reedom_point.toString(),
            //"coupon": coupon.toString(),
            "taxes_and_charges": taxes_and_charges.toString(),
            "sub_total": sub_total.toString(),
            "total": total.toString(),
          }
           :
          status_mode == "0"
              ? {
                  "userId": user_id,
                  "orderId": orderId.toString(),
                  "cartId": cartId,
                  "status_mode": status_mode.toString(),
                  "address": addressId.toString(),
                  "delivery_charge": delivery_charge.toString(),
                  "reedom_point": reedom_point.toString(),
                  "coupon": coupon.toString(),
                  "taxes_and_charges": taxes_and_charges.toString(),
                  "sub_total": sub_total.toString(),
                  "total": total.toString(),
                }
              : {
                  "userId": user_id,
                  "orderId": orderId.toString(),
                  "status_mode": status_mode.toString(),
                  "cartId": cartId.toString(),
                  "delivery_charge": delivery_charge.toString(),
                  "reedom_point": reedom_point.toString(),
                  "coupon": coupon.toString(),
                  "taxes_and_charges": taxes_and_charges.toString(),
                  "sub_total": sub_total.toString(),
                  "total": total.toString(),
                });
      var resData = json.decode(res.body);
      orderlistt.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        orderlistt.add(resData["data"]);
        Utils().sendMassage('${resData['msg'].toString()}');
        update();
        isloading.value = false;
        Get.to(DashboardScreen());
      } else {
        print('uiiiiiioio${resData.toString()}');
        Utils().sendMassage('${resData['msg'].toString()}');
        isloading.value = false;
      }
    } catch (e) {

    }
  }

  Future placeorderlist() async {
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var res =
          await http.post(Uri.parse("${base_url}order_place_list"), body: {
        "userId": user_id,
      });
      var resData = json.decode(res.body);
      placeorderlistt.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        placeorderlistt.add(resData["data"]);
        update();
        isloading.value = false;
        return placeorderlistt;
      } else {
        // Utils().sendMassage('${resData['msg'].toString()}');
        isloading.value = false;
      }
    } catch (e) {}
  }

  Future revielist(rev,des,orid) async {
    loader();
    var shared_preferences = await SharedPreferences.getInstance();
    var user_id = shared_preferences.get("user_id");
    try {
      var res =
      await http.post(Uri.parse("${base_url}give_rating"), body: {
        "userId": user_id,
        "rating":rev.toString(),
        "review":des.toString(),
        "orderId":orid.toString()

      });
      var resData = json.decode(res.body);
    //  placeorderlistt.clear();
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
        Utils().sendMassage('${resData['msg'].toString()}');
       // placeorderlistt.add(resData["data"]);
        update();
        isloading.value = false;
        Get.to(()=>TrackOrder());
        // return placeorderlistt;
      } else {
        // Utils().sendMassage('${resData['msg'].toString()}');
        isloading.value = false;
      }
    } catch (e) {}
  }
}
