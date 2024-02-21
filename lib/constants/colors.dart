import 'package:flutter/material.dart';

class ConstColors {
  static const Color yellow = Color(0xffFFC107);
  static const Color male = Color(0xff37b3cc);
  static const Color female = Color(0xfff37ea7);
  static const Color grey = Color.fromRGBO(138, 138, 138, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color noColor = Color.fromRGBO(0, 0, 0, 0);
  static const Color primaryColor =
      Color.fromRGBO(0, 122, 188, 0.8313725490196079);
  static const Color primaraayColor = Color.fromRGBO(
      2, 100, 154, 1.0);

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}
