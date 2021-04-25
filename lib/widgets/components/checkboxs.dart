import 'package:flutter/material.dart';

class Checkboxs {
  static basic(
      {BuildContext context, bool value, Function onChanged, Widget widget}) {
    return Row(
      children: <Widget>[
        Checkbox(
          activeColor: Color(0xfff2708f),
          value: value,
          onChanged: onChanged,
        ),
        widget,
      ],
    );
  }

  static circle(
      {BuildContext context, bool value, Function onChanged, Widget widget}) {
    return Row(
      children: <Widget>[
        Checkbox(
          activeColor: Color(0xfff2708f),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(15)
          // ),
          value: value,
          onChanged: onChanged,
        ),
        widget,
      ],
    );
  }
}
