import 'dart:ui';

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

  static blur({BuildContext context, String path, double height, double width, Widget widget}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(path),
            fit: BoxFit.fill
        )
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          child: widget
        ),
      ),
    );
  }
}
