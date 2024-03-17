import 'package:buddy_pizza/view/theme/color.dart';
import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const CustomIndicator(
      {super.key, required this.currentIndex, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Container(
          width: 5,
          height: 5,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                currentIndex == index ? primaryColor : const Color(0xffc6c6c6),
          ),
        ),
      ),
    );
  }
}
