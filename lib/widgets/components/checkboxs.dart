import 'package:flutter/material.dart';

class Checkboxs {
  static basic({BuildContext context, bool value, Function onChanged, Widget widget}){
    return Row(
      children: <Widget>[
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        widget,
      ],
    );
  }
}