import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const green = Color(0xFF3CED78);
  static const lightGrey = Color(0xFFEDF2F6);
  static const grey = Color(0xFF9DB7CB);
  static const black = Color(0xFF2B333E);
  static const darkGreen = Color(0xFF00521C);
  static const darkGrey = Color(0xFF5E7A90);

  static Color getRandomBrightColor() {
    Random random = Random();

    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);

    red = (red * 0.6).round();
    green = (green * 0.6).round();
    blue = (blue * 0.6).round();

    return Color.fromARGB(255, red, green, blue);
  }
}
