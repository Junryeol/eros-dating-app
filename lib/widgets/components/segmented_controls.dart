import 'package:flutter/cupertino.dart';

import 'labels.dart';

class SegmentedControls {
  static basic({BuildContext context, String labelText, Map<dynamic, Widget> children, dynamic groupValue, Function onValueChanged}){
    return Column(
      children: <Widget>[
        Labels.basic(
            context: context,
            labelText: labelText
        ),
      Container(
        width: double.infinity,
        child: CupertinoSegmentedControl(
          children: children,
          selectedColor: Color(0xffffaec1),
          padding: EdgeInsets.all(0),
          unselectedColor: Color(0xffffffff),
          borderColor: Color(0xffffaec1),
          onValueChanged: onValueChanged,
          groupValue: groupValue,
        ),
      )],
    );
  }
}