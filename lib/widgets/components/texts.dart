import 'package:flutter/material.dart';

class Texts {
  static fitWidth({BuildContext context, String text, TextAlign textAlign}){
    return Container(
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(text,
            style: const TextStyle(
                color: const Color(0xff706569)),
            textAlign: textAlign),
      ),
    );
  }

  static basic({BuildContext context, String text, TextAlign textAlign}){
    return Container(
      height: 20,
      width: double.infinity,
      child: Text(text,
            style: const TextStyle(
                color:  const Color(0xff706569),
                fontWeight: FontWeight.w500,
                fontSize: 14.0),
            textAlign: textAlign),
    );
  }
}