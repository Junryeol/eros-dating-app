import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class Images {
  static asset({BuildContext context, String path = 'assets/images/profile_test.png', double height, double width, Border border, double borderRadius=0, Widget widget }) {
    return Container(
      child: widget,
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          image: DecorationImage(
              image: AssetImage(path),
              fit: BoxFit.fill
          )
      ),
      clipBehavior: Clip.hardEdge,
    );
  }

  static file({BuildContext context, File file, double height, double width, Border border, double borderRadius=0, Widget widget }) {
    return Container(
      child: widget,
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          image: DecorationImage(
              image: Image.file(file).image,
              fit: BoxFit.fill
          )
      ),
      clipBehavior: Clip.hardEdge,
    );
  }

  static blackandwhite({BuildContext context, String path, double height, double width, Border border, double borderRadius=0, Widget widget }) {
    return Container(
      child: widget,
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          image: DecorationImage(
              image: AssetImage(path ?? 'assets/images/profile_test.png'),
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.hue),
              fit: BoxFit.fill
          )
      ),
      clipBehavior: Clip.hardEdge,
    );
  } 
}
