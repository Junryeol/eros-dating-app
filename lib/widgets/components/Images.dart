import 'package:flutter/material.dart';

class Images {
  static basic({BuildContext context, String path, double height, double width, double borderRadius=0, Widget widget}) {
    return Container(
      child: widget,
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
              image: AssetImage(path),
              fit: BoxFit.fill
          )
      ),
    );
  }
}
