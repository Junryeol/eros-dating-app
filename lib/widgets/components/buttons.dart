import 'package:eros/configs/skin.dart';
import 'package:flutter/material.dart';

class Buttons {
  static primary({BuildContext context, String text, Function onPressed, bool active = true, double height = 64.0, double width = double.infinity, double borderRadius = 15, double fontSize = 14.0, FontWeight fontWeight = FontWeight.w700 }){
    return Ink(
      height: height,
      width: width,
      decoration: active ? BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment(0, 0.5416666865348816),
            end: Alignment(1, 0.5520833134651184),
            colors: [const Color(0xffffaec1), const Color(0xfff2708f)]
        ),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ) : BoxDecoration(
        color: Color(0xffd8d2d2),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      child: active ? TextButton(
        child: Container(
            child: Text(text, style: TextStyle(color: Color(0xffffffff), fontSize: fontSize, fontWeight: fontWeight,)),
        ),
        onPressed: onPressed,
      ) : Center(
        child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: Color(0xffffffff), fontSize: fontSize, fontWeight: fontWeight,)),
    ),
    );
  }

  static transparency({BuildContext context, String text, Function onPressed, double height=64.0, double fontSize = 14.0, fontWeight = FontWeight.w300}){
    return Ink(
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Container(
          child: Text(text, style: TextStyle(color: Color(0xffd8d2d2), fontSize: fontSize, fontWeight: fontWeight,)),
        ),
        onPressed: onPressed,
      ),
    );
  }

  static cash({BuildContext context, String text, Function onPressed, double fontSize = 14.0, fontWeight = FontWeight.w300}){
    return Ink(
      child: TextButton(
        child: Container(
          child: Text(text, style: TextStyle(color: Color(0xffd8d2d2), fontSize: fontSize, fontWeight: fontWeight,)),
        ),
        onPressed: onPressed,
      ),
    );
  }

  static content({BuildContext context, Widget widget, Function onPressed}){
    return Ink(
      child: TextButton(
        child: widget,
        onPressed: onPressed,
      ),
    );
  }

  static onoff({BuildContext context, double width=double.infinity, double height=40.0, String text, bool selected=false, Function onPressed}) {
    return GestureDetector(
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Skin.primary : Skin.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: selected ? null : Border.all(color: Skin.primary, width: 1)
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Skin.white : Skin.primary,
            fontSize: 14.0,
            height: 16/14,
            letterSpacing: 0.56,
            fontWeight: FontWeight.w700 
          ),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: onPressed,
    );
  }

}