import 'package:eros/configs/skin.dart';
import 'package:flutter/material.dart';

class Images {
  static basic({BuildContext context, String path, double height, double width, Border border, double borderRadius=0, Widget widget, Function onTap }) {
    return Container(
      child: widget,
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          image: DecorationImage(
              image: AssetImage(path ?? 'assets/images/error.png'),
              fit: BoxFit.fill
          )
      ),
      clipBehavior: Clip.hardEdge,
    );
  }
}
