import 'dart:math';
import 'package:flutter/material.dart';

const Color primaryColor = Colors.blueGrey;
const Color backgroundColor = Color(0xff404040);
const Color lightGreyColor = Color(0xffd0cece);
const Color normalGreyColor = Color(0xffa5a5a5);
const Color darkGreyColor = Color(0xff7f7f7f);
const Color mediumGreyColor = Color(0xffd9d9d9);

const Color blueColor = Color(0xFF439FDF);
const Color darkBlueColor = Color(0xFF4572c4);
const Color blackColor = Color(0xFF383838);
const Color shadowColor = Color(0x38000000);

const Color selectedColor = Color(0xffd6a018);
const Color unSelectedColor = Colors.blueGrey;
const Color lightYellowColor = Color(0xfffff2cc);
const Color textRedColor = Color(0xffcf0500);

Color getFocusColor(int index, int selectedIndex) {
  if (index == selectedIndex) {
    return selectedColor;
  } else {
    return unSelectedColor;
  }
}

Color getRandomColor() {
  var colors = [
    Colors.deepOrange,
    Colors.yellow,
    Colors.green,
    Colors.lightGreen,
    Colors.grey,
    Colors.orangeAccent,
    Colors.orange,
    Colors.blue,
    Colors.cyanAccent,
    Colors.deepPurple
  ];
  return colors[Random().nextInt(10)];
}

LinearGradient getGradientColor({Color color = primaryColor}) {
  return LinearGradient(
    colors: [
      color.withOpacity(0.75),
      color.withOpacity(0.25),
    ],
    begin: const FractionalOffset(0.0, 0.0),
    end: const FractionalOffset(1.0, 1.0),
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp
  );
}
