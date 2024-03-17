import 'dart:async';

import 'package:buddy_pizza/view/screen/dashboard/dashboard.dart';
import 'package:buddy_pizza/view/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/homebanner_api.dart';
import 'auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final banner = Get.put(homebanner_api());
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async{
      var shared_preferences = await SharedPreferences.getInstance();
      var user_id = shared_preferences.get("user_id");
      user_id==null?
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      ):
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()));





    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: h / 2.5,
            ),
            Center(
              child: Image.asset(
                "assets/images/img.png",
                fit: BoxFit.cover,
                height: h / 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
