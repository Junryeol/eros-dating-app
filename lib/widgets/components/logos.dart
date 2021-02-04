import 'package:flutter/material.dart';

class Logos {
  static bigLogo({BuildContext context, double size}){
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
            color: const Color(0x4ff2003a),
            offset: Offset(0, size*0.2),
            blurRadius: 40,
            spreadRadius: 0
        )] ,
        color: const Color(0xffffaec1),
        borderRadius: BorderRadius.all(Radius.circular(size*0.5)),
      ),
      child: Image.asset('assets/images/heart_light.png', fit: BoxFit.none, cacheWidth: (size*0.8).toInt(),),
    );
  }
}