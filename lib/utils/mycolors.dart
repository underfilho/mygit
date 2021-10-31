import 'package:flutter/material.dart';

MyColors myTheme = MyColors.dark();

class MyColors {
  final Color background;
  final Color accent;
  final Color divider;
  final Color textColor;

  MyColors.light() :
    background = Colors.white,
    accent = Color(0xffCDCDCF),
    divider = Color(0xffCDCDCF),
    textColor = Color(0xff161b22);

  MyColors.dark() :
    background = Color(0xff161b22),
    accent = Color(0xff373A3E),
    divider = Color(0xffCDCDCF),
    textColor = Colors.white;
}
