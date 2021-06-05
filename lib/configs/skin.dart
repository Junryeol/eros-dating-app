import 'package:flutter/material.dart';

class Skin {
  static final transparency = Color(0x00000000);
  static final white = Color(0xffffffff);
  static final black = Color(0xff252528);
  static final grey = Color(0xff706569);
  static final lightgrey = Color(0xffd8d2d2);
  static final bordergrey = Color(0xff9a9297);
  static final primary = Color(0xfff2708f);
  static final secondary = Color(0xffffaec1);
  static final disabled = Color(0xccebe8e8);
  static final unselected = Color(0xfff6f6f6);
  static final unselectedText = Color(0xffb2adad);
  static final shadow = Color(0x33ab4960);
  static final chatText = Color(0xff595959);
  static final bubbleLeft = Color(0xfffffcf3);
  static final bubbleRight = Color(0xfffff3f6);

  static ThemeData light() {
    var brightness = Brightness.light;
    var backgroundColor = white;
    var primaryColor = primary;
    var textTheme = TextTheme(bodyText1: TextStyle(color: grey), button: TextStyle(color: grey), bodyText2: TextStyle(color: grey));

    return ThemeData(
      brightness: brightness,
      backgroundColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'KoPubDotum',
      primaryColor: primaryColor,
      accentColor: primaryColor,
      textTheme: textTheme
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
