import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro/custom/custom_text.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  late List<int> available = <int>[1, 10, 15, 20, 25, 30, 35, 40, 45, 50];
  late int selectedValue = available[4];
  late double percentage = 0.0;
  late int duration = (selectedValue*60);
  Timer? timer;
  bool notUsed = true;
  bool dropDown = true;

  void count(){
    dropDown = false;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        notUsed = false;
        percentage += (100/(selectedValue*60));
        duration -= 1;
        if(percentage>100){
          notUsed = true;
          percentage = 0.0;
          duration = (selectedValue*60);
          timer?.cancel();
          AudioPlayer().play(AssetSource("audio/completed.mp3"));
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
   
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: CustomPaint(
                foregroundPainter: MyPainter(
                    lineColor: Colors.grey,
                    completeColor: Colors.red,
                    completePercent: percentage,
                    width: 8.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: const Center(
                      child: CustomText(
                        text: "Start",
                        fontSize: 30,
                        fontColor: Colors.black,
                      ),
                    ),
                    onTap: () {
                      if(notUsed){
                      count();
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),

            // Timer
            CustomText(
              // text: duration.toString(),
              text: Duration(minutes: duration~/60, seconds: (duration%60)).toString().substring(2,7),
              fontSize: 30,
              fontColor: Colors.black,
            ),
            const SizedBox(height: 20,),

            // Select Time
            DropdownMenu(
              initialSelection: selectedValue,
              enabled: dropDown,
              onSelected: (int ?value) {
                setState(() {
                  selectedValue = value!;
                  duration = (value * 60);
                });
              },
              dropdownMenuEntries: available.map<DropdownMenuEntry<int>>((int value) {
                return DropdownMenuEntry<int>(value: value, label: ("$value Min"));
              }).toList(),
              ),
            const SizedBox(height: 20,),
            
            // Stop Timer
            GestureDetector(
              onTap: () {
                setState(() {
                  notUsed = true;
                  percentage = 0.0;
                  duration = (selectedValue*60);
                  AudioPlayer().play(AssetSource("audio/cancel.mp3"));
                  timer?.cancel();
                  dropDown = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const CustomText(
                  text: "Cancel",
                  fontColor: Colors.white,
                  fontSize: 26,
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}





class MyPainter extends CustomPainter{
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;
  MyPainter({
    required this.lineColor,
    required this.completeColor,
    required this.completePercent,
    required this.width,
    });
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
        ..color = lineColor
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = width;
    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center  = Offset(size.width/2, size.height/2);
    double radius  = min(size.width/2,size.height/2);
    canvas.drawCircle(
        center,
        radius,
        line
    );
    double arcAngle = 2*pi* (completePercent/100);
    canvas.drawArc(
        Rect.fromCircle(center: center,radius: radius),
        -pi/2,
        arcAngle,
        false,
        complete
    );
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}