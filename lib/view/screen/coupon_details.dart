import 'package:buddy_pizza/view/screen/dashboard/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/offerlist_api.dart';
import '../api/orderplaceed_api.dart';
import '../base/custom_button.dart';
import '../theme/color.dart';
import '../theme/text2.dart';
import '../utils/constant.dart';
import 'dashboard/home/your_order.dart';
import 'dashboard/profile/profile_details/profile_screen.dart';

class CouponDetails extends StatefulWidget {
  final index;
  const CouponDetails({super.key, this.index});

  @override
  State<CouponDetails> createState() => _CouponDetailsState();
}

class _CouponDetailsState extends State<CouponDetails> {
  final offerlistapi = Get.put(offerlist_api());
  final placedorder = Get.put(Orderplaced_api());

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery
        .of(context)
        .size
        .height;
    final w = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          "Coupon Details",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "${user_image_url}${offerlistapi!.offerlistt[0][widget
                  .index]["image"]}",

              fit: BoxFit.cover,
              width: w,
              height: h / 3,
            ),
            SizedBox(
              height: h / 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${offerlistapi!.offerlistt[0][widget
                        .index]["title"]}   ${offerlistapi!.offerlistt[0][widget
                        .index]["off_percantage"]}% off",
                    style: Text_Lit_Bold,
                  ),
                  Text(
                    "Code: ${offerlistapi!.offerlistt[0][widget
                        .index]["coupon_code"]}",
                    style: Text_Lit_Bold,
                  ),
                  Text(
                    "Valid: ${offerlistapi!.offerlistt[0][widget
                        .index]["valid_date"].toString().substring(0, 10)}",
                    style: A_style_order,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 3)]),
        child: CustomButton(
          title: 'Redeem',
          onTap: () {
            showMyDialog(context);
          },
        ),
      ),
    );
  }


  showMyDialog(BuildContext context) async {
    final h = MediaQuery
        .of(context)
        .size
        .height;
    final w = MediaQuery
        .of(context)
        .size
        .width;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
              child: Image.asset(
                "assets/images/coupon.gif",
                height: 60,
              )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Are you sure add coupon code?',
                  style: A_style_medium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: w / 5,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: TextButton(
                      style: flatButtonStyle,
                      onPressed: () {
                        placedorder.applycoupen(
                            offerlistapi!.offerlistt[0][widget.index]["_id"]
                        , offerlistapi!.offerlistt[0][widget.index]["off_percantage"]);


                        // Get.to(() => MenuScreen());
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>  EmailLoginDelivery()),
                        //         (route) => false);
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Ember_Bold"),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Get.offAll(() => const HomeScreen());
                  },
                  child: Container(
                    width: w / 5,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: TextButton(
                      style: flatButtonStyle,
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Ember_Bold"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}