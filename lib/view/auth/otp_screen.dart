import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/verify_api.dart';
import '../theme/color.dart';
import '../theme/text2.dart';
import '../utils/utils.dart';

var one;

class OtpScreen extends StatefulWidget {
  const OtpScreen(
      {super.key,
      required this.otp,
      required this.userid,
      required this.countrycode,
      required this.mobileno});

  final String countrycode;
  final String userid;
  final String otp;
  final String mobileno;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _otpController = TextEditingController();
  bool _isVerifyButtonEnabled = false;
  bool isloading = false;
  String otp = '';
  String otpResendValue = '';
  String mobiles = '';
  bool showCenter = false;
  int _remainingTime = 60;
  bool _isTimerActive = false;
  Timer? _timerr;
  bool? isChecked = false;
  bool _onEditing = true;
  String? _code;
  final Verifyapi = Get.put(verify_api());

  // generateOTP() {
  //   setState(() {
  //     one = (1000 + Random().nextInt(9000)).toString();
  //   });
  // }

  void startTimer() {
    setState(() {
      _isTimerActive = true;
    });

    _timerr = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        stopTimer();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  void stopTimer() {
    setState(() {
      _isTimerActive = false;
    });
    if (_timerr != null) {
      _timerr!.cancel();
    }
  }

  void resendOTP() {
    setState(() {
      _remainingTime = 30;
    });
    startTimer();
  }

  int _secondsRemaining = 30;
  late Timer _timer;
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();
    //otp = widget.otp;
  }

  void getMobileFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mobiles = prefs.getString('mobile') ?? '';
    });
  }

  String errorMessage = '';
  String existingOTP = "3284";

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final defaultPinTheme = PinTheme(
      margin: const EdgeInsets.only(right: 2),
      width: 65,
      height: 65,
      textStyle: const TextStyle(
          fontSize: 20, color: primaryColor, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h / 20,
              ),
              Center(
                child: Text("Verify Your Mobile Number", style: MediumSizeText),
              ),
              SizedBox(
                height: h / 20,
              ),
              Center(
                  child: Text('Please enter the code send to',
                      style: A_style_mid)),
              SizedBox(
                height: h / 50,
              ),
              Center(
                child: Text('+${widget.countrycode} - ${widget.mobileno}',
                    style: A_style_mid),
              ),
              SizedBox(
                height: h / 28,
              ),
              Center(
                child:
                    Text('OTP : ${newotp ?? widget.otp}', style: A_style_mid),
              ),
              SizedBox(
                height: h / 28,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: h / 14.8,
                  width: w / 1.3,
                  child: Pinput(
                      controller: _otpController,
                      onChanged: (value) {
                        setState(() {
                          _isVerifyButtonEnabled = value.length == 4;
                        });
                      },
                      //controller: off,
                      separatorBuilder: (index) => const SizedBox(width: 22),
                      length: 4,
                      defaultPinTheme: defaultPinTheme,
                      // focusedPinTheme: focusedPinTheme,
                      // submittedPinTheme: submittedPinTheme,
                      showCursor: true,
                      onCompleted: (pin) {
                        setState(() {
                          otp = pin;
                        });
                      }),
                ),
              ),
              SizedBox(height: h / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !_isTimerActive
                      ? Text(" ")
                      : Text("Resend in", style: A_style_mid),
                  // Text(" ", style: TextStyle(color: Colors.black, fontFamily: "Roboto_med", fontSize: 17),),
                  !_isTimerActive
                      ? Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _remainingTime = 60;
                                });
                                startTimer();
                                Verifyapi.resend(
                                  widget.countrycode,
                                  widget.mobileno,
                                );
                              },
                              child: Text("Resend OTP via SMS",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.red,
                                      overflow: TextOverflow.ellipsis,
                                      // fontFamily: "Amazon_med",
                                      fontSize: 14)),
                            ),
                            SizedBox(
                              height: h / 100,
                            ),
                          ],
                        )
                      : Text(
                          '  $_remainingTime seconds',
                          style: A_style_mid,
                        ),
                ],
              ),
              SizedBox(
                height: h / 20,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: primaryColor,
                    onChanged: (newBool) {
                      setState(() {
                        isChecked = newBool;
                      });
                    },
                  ),
                  Text(
                    "Send me course updates & remainders on WhatsApp",
                    style: TextStyle(fontFamily: "Amazon_med", fontSize: 10),
                  ),
                ],
              ),
              Obx(() => Verifyapi.isloading.value == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      style: buttonPrimary,
                      onPressed: _isVerifyButtonEnabled
                          ? () async {
                              if (_otpController.text.toString().isNotEmpty) {
                                await Verifyapi.verify(widget.userid.toString(),
                                    _otpController.text.toString());
                              } else {
                                Utils().alertbox(' Please entre mobile no ');
                              }
                              setState(() {
                                isloading = true;
                              });
                            }
                          : null,
                      child: Text("Verify", style: Text_inside_button))),
            ],
          ),
        ),
      ),
    );
  }

  void congr() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          content: Container(
              height: 200,
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Center(
                  //     child:
                  //     Image.asset("assets/images/Screenshot__30_-removebg-preview11.png",scale: 1.7)),
                  // SizedBox(
                  //     height: 15),
                  Center(
                    child: Text(
                      "Congratulations Amit",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      color: primaryColor,
                      size: 50,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Your account has been created",
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 20),
                  Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
