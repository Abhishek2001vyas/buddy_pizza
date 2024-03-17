import 'dart:io';

import 'package:buddy_pizza/view/api/givefeedback_api.dart';
import 'package:buddy_pizza/view/base/custom_button.dart';
import 'package:buddy_pizza/view/screen/dashboard/profile/profile_details/track_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/homebanner_api.dart';
import '../../../../auth/login.dart';
import '../../../../controller.dart';
import '../../../../theme/color.dart';
import '../../../../theme/text2.dart';
import 'faq.dart';
import 'privacy_policy.dart';
import 'term_condition.dart';

TextEditingController feedback = TextEditingController();
var rev = 4.0;

final givefeedback = Get.put(givefeedback_api());

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: Colors.black87, minimumSize: const Size(78, 16),
  padding: const EdgeInsets.symmetric(horizontal: 8),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);




class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    saveAddressToSharedPreferences();
    super.initState();
  }
  final banner = Get.put(homebanner_api());

  var userno;
  void saveAddressToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
     userno=prefs.getString("userno");
   });

    print("poiuytrewq${userno}");
    // prefs.setString('address', address);
  }

  @override
  Widget build(BuildContext context) {
    PizzaController controller = Get.put(PizzaController());
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: const Text(
          "Account",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(
                top: 8,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade200, blurRadius: 2),
                  ],
                  border: Border.all(color: Colors.grey.shade200, width: 1)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.getFromGallery();
                    },
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: controller.imageFile != null
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              backgroundImage: FileImage(
                                  File(controller.imageFile.toString())))
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              backgroundImage: AssetImage(
                                "assets/images/profile.png",
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: w / 20,
                  ),
                  Text("${userno}", style: Text_Lit_Bold),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Amit",
                  //       style: Text_Lit_Bold,
                  //     ),
                  //
                  //   ],
                  // ),
                  const Spacer(),
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      //  Get.to(() => const EditProfile());
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: h / 80,
            ),
            Container(
              padding: EdgeInsets.all(6),
              margin: const EdgeInsets.only(
                top: 8,
              ),
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade200, blurRadius: 2),
                  ],
                  border: Border.all(color: Colors.grey.shade200, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Loyalty Points",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    width: w / 80,
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 1),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200, blurRadius: 3)
                          ]),
                      child:   FutureBuilder(future: banner.loyalty(), builder: (context, snapshot) {
                        return Text(
                          "${loyaltypoint[0]} Points",
                          style: verySmallText,
                        );
                      },)
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const TrackOrder());
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200, blurRadius: 2),
                    ],
                    border: Border.all(color: Colors.grey.shade200, width: 1)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Track order",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: primaryColor,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => TermsCondition());
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200, blurRadius: 2),
                    ],
                    border: Border.all(color: Colors.grey.shade200, width: 1)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Term & Conditions",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: primaryColor,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => PrivacyPolicy());
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200, blurRadius: 2),
                    ],
                    border: Border.all(color: Colors.grey.shade200, width: 1)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Privacy",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: primaryColor,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const FAQ());
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200, blurRadius: 2),
                    ],
                    border: Border.all(color: Colors.grey.shade200, width: 1)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "FAQs",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: primaryColor,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _modalBottomSheetMenuShareFeedback(context);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200, blurRadius: 2),
                    ],
                    border: Border.all(color: Colors.grey.shade200, width: 1)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Give feedback",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: primaryColor,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (builder) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: h / 3.6,
                              color: Colors.transparent,
                              child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0))),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Rate Us",
                                                style: A_style_medium),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.close,
                                                  color: Colors.grey.shade800),
                                            )
                                          ],
                                        ),
                                        Divider(color: Colors.grey.shade200),
                                        Center(
                                          child: RatingBar.builder(
                                            initialRating: 2,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                            ),
                                            onRatingUpdate: (rating) {
                                              setState(() {
                                                rev = rating;
                                              });
                                              print(rating);
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Obx(() =>
                                            givefeedback.isloading1 == true
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : CustomButton(
                                                    title: "Submit",
                                                    onTap: () async {
                                                      await givefeedback.rating(
                                                          rev.toString());
                                                      Navigator.pop(context);
                                                    })),
                                      ])),
                            ),
                          ],
                        ),
                      );
                    });
                //  _modalBottomSheetMenuRateUs(context);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200, blurRadius: 2),
                    ],
                    border: Border.all(color: Colors.grey.shade200, width: 1)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rate us",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: primaryColor,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.defaultDialog(
                  title: "Logout",
                  content: Text("Are comform logout"),
                  cancel: GestureDetector(
                    onTap: ()async{
                      Get.back();
                    },
                    child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.red),
                        width: 60,height: 40,
                        child: Center(child: Text("cancel",style: TextStyle(color: Colors.white),))),
                  ),
                  confirm: GestureDetector(
                    onTap: ()async{
                      var shared_preferences = await SharedPreferences.getInstance();
                      shared_preferences.remove("user_id");
                      Get.offAll(Login());
                    },
                    child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.red),
                        width: 60,height: 40,
                        child: Center(child: Text('ok',style: TextStyle(color: Colors.white),))),
                  ),



                );
                //  _modalBottomSheetMenuRateUs(context);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200, blurRadius: 2),
                    ],
                    border: Border.all(color: Colors.grey.shade200, width: 1)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Log out",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showMyDialog(BuildContext context) async {
  final h = MediaQuery.of(context).size.height;
  final w = MediaQuery.of(context).size.width;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Center(
            child: Icon(Icons.login_sharp, size: 30, color: Color(0xff1455ac))),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Logout from Delivery App?',
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
                  //   Get.offAll(() => const HomeScreen());
                },
                child: Container(
                  width: w / 5,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
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

// void _modalBottomSheetMenuRateUs(BuildContext context) {
//   final h = MediaQuery.of(context).size.height;
//   final w = MediaQuery.of(context).size.width;
//
// }

void _modalBottomSheetMenuShareFeedback(BuildContext context) {
  final h = MediaQuery.of(context).size.height;
  final w = MediaQuery.of(context).size.width;
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (builder) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: h / 2.3,
                color: Colors.transparent,
                child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Share your Feedback",
                                style: A_style_medium,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close,
                                    color: Colors.grey.shade800),
                              )
                            ],
                          ),
                          Divider(color: Colors.grey.shade200),
                          TextField(
                            controller: feedback,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Write your feedback',
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 17,
                                  fontFamily: "Roboto_thin"),
                            ),
                            maxLines: 5,
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => givefeedback.isloading == true
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomButton(
                                    title: "Submit",
                                    onTap: () async {
                                      await givefeedback
                                          .feedback(feedback.text.toString());
                                      Navigator.pop(context);
                                    }),
                          )
                        ])),
              ),
            ],
          ),
        );
      });
}
