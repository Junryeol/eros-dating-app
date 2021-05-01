import 'dart:ui';

import 'package:flutter/material.dart';

class Images {
  static basic({BuildContext context, String path, double height, double width, Border border, double borderRadius=0, Widget widget }) {
    return Container(
      child: widget,
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          image: DecorationImage(
              image: AssetImage(path ?? 'assets/images/profile_test.png'),
              fit: BoxFit.fill
          )
      ),
      clipBehavior: Clip.hardEdge,
    );
  }
}
