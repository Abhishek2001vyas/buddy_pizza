import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton1 extends StatefulWidget {
  final String title;
  final Function onTap;
  final double? width;
  final double? height;
  final double? radius;

  const CustomButton1(
      {Key? key,
      required this.title,
      required this.onTap,
      this.width,
      this.height,
      this.radius})
      : super(key: key);

  @override
  State<CustomButton1> createState() => _CustomButton1State();
}

class _CustomButton1State extends State<CustomButton1> {
  // GetxControllers controller = Get.put(GetxControllers());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        height: widget.height ?? 50,
        width: Get.width,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.radius ?? 5),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Ember_Display_Medium'),
          ),
        ),
      ),
    );
  }
}
