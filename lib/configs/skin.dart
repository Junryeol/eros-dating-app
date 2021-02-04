import 'package:flutter/material.dart';

class Skin {
  static final transparency = Color(0x00000000);
  static final white = Color(0xffffffff);
  static final black = Color(0xff252528);
  static final grey = Color(0xff706569);
  static final primary = Color(0xffffaec1);

  static ThemeData light() {
    var brightness = Brightness.light;
    var backgroundColor = white;
    var primaryColor = grey;

    return ThemeData(
      brightness: brightness,
      backgroundColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'KoPubDotum',
      primaryColor: primaryColor,
      accentColor: primaryColor,
    );
  }

  static ThemeData dark() {
    var brightness = Brightness.dark;
    var backgroundColor = black;
    var primaryColor = grey;

    return ThemeData(
        brightness: brightness,
        backgroundColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'KoPubDotum',
        primaryColor: primaryColor,
        accentColor: primaryColor,
    );
  }

}
