import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static alert({BuildContext context, String title, String content, Function OnPressed}){
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
            color: Color(0xff252528),
            fontSize: 20,
            letterSpacing: 1.6,
            fontWeight: FontWeight.w700
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0.0),
      content: Text(
        content,
        style: TextStyle(
            color: Color(0xff9a9297),
            height: 1.7,
            fontSize: 14,
            letterSpacing: 0.28,
            fontWeight: FontWeight.w300
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: Text(
              tr('confirm'),
              style: TextStyle(
                  color: Color(0xfff2708f),
                  fontSize: 20,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700
              ),
            ),
            onPressed: OnPressed
        ),
      ],
    );
  }

  static confirm({BuildContext context, String title, String content, Function cancelOnPressed, Function confirmOnPressed}){
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
            color: Color(0xff252528),
            fontSize: 20,
            letterSpacing: 1.6,
            fontWeight: FontWeight.w700
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0.0),
      content: Text(
        content,
        style: TextStyle(
            color: Color(0xff9a9297),
            height: 1.7,
            fontSize: 14,
            letterSpacing: 0.28,
            fontWeight: FontWeight.w300
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: Text(
              tr('cancel'),
              style: TextStyle(
                  color: Color(0xff9a9297),
                  fontSize: 20,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700
              ),
            ),
            onPressed: cancelOnPressed
        ),
        TextButton(
            child: Text(
              tr('confirm'),
              style: TextStyle(
                  color: Color(0xfff2708f),
                  fontSize: 20,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700
              ),
            ),
            onPressed: confirmOnPressed
        ),
      ],
    );
  }

  static option({
    BuildContext context, 
    String title, 
    int length, 
    Widget Function(int) itemBuilder, 
    Function(int) onPressItem
  }) {
    return SimpleDialog(
      title: title != null ? Text(
        title,
        style: TextStyle(
            color: Color(0xff252528),
            fontSize: 20,
            letterSpacing: 1.6,
            fontWeight: FontWeight.w700
        ),
      ) : null,
      children: Iterable<int>.generate(length).toList().map((i) {
        return SimpleDialogOption(
          child: itemBuilder(i),
          onPressed: () {
            onPressItem(i);
            Navigator.of(context).pop();
          } 
        );
      }).toList(),
    );
  }
}