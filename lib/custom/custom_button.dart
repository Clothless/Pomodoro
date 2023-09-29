import 'package:flutter/material.dart';
import 'package:pomodoro/custom/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color fontColor;
  final Color backgroundColor;
  final double width;
  final double height;
  final double? borderRadius;
  final Function? click;


  const CustomButton({
    super.key,
    this.text = "Click",
    this.fontSize = 16,
    this.fontColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.width = 100,
    this.height = 50,
    this.borderRadius,
    this.click,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        
      },
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: CustomText(
          text: text,
          fontSize: fontSize,
          fontColor: fontColor,
        ),
    
      ),
    );
  }
}