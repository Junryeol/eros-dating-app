import 'package:flutter/cupertino.dart';

import 'labels.dart';

class SegmentedControls {
  static basic({BuildContext context, String labelText, Map<dynamic, Widget> children, dynamic groupValue, Function onValueChanged, EdgeInsetsGeometry padding
    , double height = 14.0, double width = double.infinity, double fontSize = 14.0, FontWeight fontWeight = FontWeight.w500}){
    padding = padding != null ? padding : EdgeInsets.all(0);

    return Column(
      children: <Widget>[
        Labels.basic(
            context: context,
            labelText: labelText,
          height: height,
          width: width,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      Container(
        width: width,
        child: CupertinoSegmentedControl(
          children: children,
          selectedColor: Color(0xffffaec1),
          padding: padding,
          unselectedColor: Color(0xffffffff),
          borderColor: Color(0xffffaec1),
          onValueChanged: onValueChanged,
          groupValue: groupValue,
        ),
      )],
    );
  }
}