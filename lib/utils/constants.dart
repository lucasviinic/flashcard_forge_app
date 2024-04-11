import 'package:flutter/material.dart';

class Styles {
  static const Color secondaryColor = Color.fromARGB(255, 17, 16, 16);
  static const Color primaryColor = Colors.black;
  static const Color accentColor = Color.fromARGB(255, 16, 130, 156);
  static const Color greenEasy = Colors.green;
  static const Color redHard = Colors.red;
  static const Color blueNeutral = Colors.blue;

  static const LinearGradient linearGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 26, 25, 25),
      secondaryColor,
    ],
  );
}
