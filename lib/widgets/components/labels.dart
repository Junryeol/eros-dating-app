import 'package:flutter/material.dart';

class Labels {
  static basic({BuildContext context, String labelText, double height = 14.0, double width = double.infinity, double fontSize = 14.0, FontWeight fontWeight = FontWeight.w500}) {
    return Container(
      height: height,
      width: width,
      child: Text(labelText,
          style: TextStyle(
              color:  Color(0xff706569),
              fontWeight: fontWeight,
              fontSize: fontSize),
          textAlign: TextAlign.left),
    );
  }
}
