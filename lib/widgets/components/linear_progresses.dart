import 'package:flutter/material.dart';

class LinearProgresses {
  static basic({BuildContext context, double value}){
    return LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(const Color(0xfff2708f)),
      value: value,
    );
  }
}