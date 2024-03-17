import 'dart:async';

import 'package:buddy_pizza/view/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({super.key});

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/successfully.gif",
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Order placed successfully",
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.green.shade500,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
