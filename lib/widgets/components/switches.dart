import 'package:flutter/material.dart';

class Labels {
  static basic({BuildContext context, bool value, Function onChanged}) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: const Color(0xfff2708f),
      activeColor: Color(0xffffaec1),
    );
  }
}
