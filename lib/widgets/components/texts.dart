import 'package:flutter/material.dart';

class Texts {
  static fitWidth({BuildContext context, String text, TextAlign textAlign, double width = double.infinity, double fontSize = 14.0, FontWeight fontWeight = FontWeight.w500}){
    return Container(
      width: width,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(text,
            style: TextStyle(
                fontSize:fontSize,
                fontWeight:fontWeight,
                color: Color(0xff706569)),
            textAlign: textAlign),
      ),
    );
  }

  static basic(
      {BuildContext context, String text, TextAlign textAlign, double height = 20.0, double width = double.infinity, double fontSize = 14.0, FontWeight fontWeight = FontWeight.w500}){
    return Container(
      height: height,
      width: width,
      child: Text(text,
          style: TextStyle(
            color:  Color(0xff706569),
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
          textAlign: textAlign),
    );
  }

  static primary(
      {BuildContext context, String text, TextAlign textAlign, double height = 20.0, double width = double.infinity, double fontSize = 14.0, FontWeight fontWeight = FontWeight.w500}){
    return Container(
      height: height,
      width: width,
      child: Text(text,
          style: TextStyle(
            color:  Color(0xfff2708f),
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
          textAlign: textAlign),
    );
  }

  static secondary(
      {BuildContext context, String text, TextAlign textAlign, double height = 20.0, double width = double.infinity, double fontSize = 14.0, FontWeight fontWeight = FontWeight.w500}){
    return Container(
      height: height,
      width: width,
      child: Text(text,
          style: TextStyle(
            color:  Color(0xffd8d2d2),
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
          textAlign: textAlign),
    );
  }

  static cash(
      {BuildContext context, String text, TextAlign textAlign, double height = 20.0, double width = double.infinity, double fontSize = 14.0, FontWeight fontWeight = FontWeight.w500}){
    return Container(
      height: height,
      width: width,
      child: Text(text,
          style: TextStyle(
            color:  Color(0xfff4b146),
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
          textAlign: textAlign),
    );
  }
}