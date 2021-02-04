import 'package:flutter/material.dart';

class Buttons {
  static primary({BuildContext context, String text, Function onPressed, bool active = true}){
    return Ink(
      height: 48,
      width: double.infinity,
      decoration: active ? BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment(0, 0.5416666865348816),
            end: Alignment(1, 0.5520833134651184),
            colors: [const Color(0xffffaec1), const Color(0xfff2708f)]),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ) : BoxDecoration(
        color: Color(0xffd8d2d2),
    borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
      child: active ? FlatButton(
        child: Container(
            child: Text(text, style: TextStyle(color: Color(0xffffffff), fontSize: 14, fontWeight: FontWeight.w700,)),
        ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ) : Center(
        child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: Color(0xffffffff), fontSize: 14, fontWeight: FontWeight.w700,)),
    ),
    );
  }

  static transparency({BuildContext context, String text, Function onPressed}){
    return Ink(
      child: FlatButton(
        child: Container(
          child: Text(text, style: TextStyle(color: Color(0xffd8d2d2), fontSize: 14, fontWeight: FontWeight.w300,)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}