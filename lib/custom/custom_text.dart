import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color fontColor;
  final String? fontFamily;
  final double fontSize;

  const CustomText({
    super.key,
    this.text = "",
    this.fontColor = Colors.white,
    this.fontFamily,
    this.fontSize = 16.0,

    });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: fontColor,
        fontFamily: fontFamily,
        fontSize: fontSize,
        

      ),);
  }
}