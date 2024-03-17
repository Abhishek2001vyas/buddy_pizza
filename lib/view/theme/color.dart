import 'package:flutter/material.dart';

const primaryColor = Color(0xffab0d07);

const black = Colors.black;
const white = Colors.white;
const button_red_color = Color(0xfff58300);
const scaffoldColor = Colors.white;
final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
    minimumSize: Size(400, 50),
    backgroundColor: primaryColor,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)));
