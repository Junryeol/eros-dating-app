import 'package:flutter/material.dart';

class Dividers {
  static vertical({BuildContext context, double thickness}) {
    return VerticalDivider(thickness: thickness,);
  }
  static horizontal({BuildContext context, double thickness}) {
    return Divider(thickness: thickness,);
  }
}
