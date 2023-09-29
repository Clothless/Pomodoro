import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool autoCorrect;
  final bool autofocus;
  final TextEditingController? controller;
  final String hint;
  final Color fontColor;
  final typingColor;
  final String fontFamily;
  final double fontSize;

  final InputBorder inputBorder;

  const CustomTextField({
    super.key, 
    this.autoCorrect = false,
    this.autofocus = false,
    this.controller,
    this.hint = "Type here...",
    this.fontColor = Colors.grey,
    this.typingColor = Colors.white,
    this.fontFamily = "",
    this.fontSize = 18.0,

    this.inputBorder = InputBorder.none,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        style: TextStyle(
          color: typingColor,
        ),
        autocorrect: autoCorrect,
        autofocus: autofocus,
        controller: controller!,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: fontColor,
            fontFamily: fontFamily,
            fontSize: fontSize,
          ),
          border: inputBorder,
          
        ),
      ),
    );
  }
}