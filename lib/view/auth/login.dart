import 'package:buddy_pizza/view/api/homebanner_api.dart';
import 'package:buddy_pizza/view/theme/text2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../api/login_api.dart';
import '../theme/color.dart';
import '../utils/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Longinapi = Get.put(signIn_api());
  final banner = Get.put(homebanner_api());

  final codeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final valid = GlobalKey<FormState>();
  RegExp pattern = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+");

  bool passwordObscured = true;

  bool isloading = false;

  bool? isChecked = false;
  var ll = 8;

  var countrycode = "228";

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Form(
              child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h / 40,
                ),
                Center(
                    child: Image.asset(
                  "assets/images/img.png",
                  scale: 3,
                  height: h / 7,
                )),
                SizedBox(
                  height: h / 20,
                ),
                Text(
                  "SignIn with Phone Number \nto continue",
                  style: TextStyle(
                      color: Color(0xff020301),
                      fontSize: 24,
                      fontFamily: "Ember_Bold"),
                ),
                SizedBox(
                  height: h / 30,
                ),
                IntlPhoneField(
                  onCountryChanged: (value) {
                    setState(() {
                      countrycode = value.dialCode;
                      ll = value.maxLength;
                    });
                  },
                  controller: phoneController,
                  validator: (value) {
                    if (value == null) {
                      return "please mobile";
                    }
                    return null;
                  },
                  flagsButtonPadding: const EdgeInsets.all(16),
                  dropdownIconPosition: IconPosition.trailing,

                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  initialCountryCode: 'BF',
                  // onChanged: (phone) {
                  //   print(phone.completeNumber);
                  // },
                ),
                SizedBox(
                  height: h / 80,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     InkWell(
                //         onTap: () {
                //           //Get.to(OtpScreen());
                //         },
                //         child: Text("Forgot Password ?", style: ButtonText)),
                //   ],
                // ),
                // SizedBox(
                //   height: h / 50,
                // ),
                Obx(() => Longinapi.isloading.value == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        style: buttonPrimary,
                        onPressed: () async {
                          if (phoneController.text.toString().length == ll) {
                            await Longinapi.signIn(
                                phoneController.text.toString(),
                                countrycode.toString());
                          } else if (phoneController.text.toString().length !=
                              ll) {
                            Utils().alertbox(
                                ' Please entre mobile no up to $ll digit ');
                          } else {
                            Utils().alertbox(' Please entre mobile no ');
                          }
                          setState(() {
                            isloading = true;
                          });
                        },
                        child: Text("Send OTP", style: Text_inside_button))),
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
