import 'package:buddy_pizza/view/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final Function onTap;
  final double? width;
  final double? height;
  final double? radius;

  const CustomButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.width,
      this.height,
      this.radius})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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
          color: primaryColor,
          borderRadius: BorderRadius.circular(widget.radius ?? 5),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Ember_Display_Medium'),
          ),
        ),
      ),
    );
  }
}
