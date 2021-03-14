import 'package:flutter/material.dart';

class AppBars {
  static basic({BuildContext context, String title, List<Widget> actions}){
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.keyboard_arrow_left, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: Text(title, style: TextStyle(color: Color(0xff706569), fontSize: 14.0),),
      backgroundColor: Colors.white,
      actions: actions,
    );
  }

  static popup({BuildContext context, String title}){
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.close, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: Text(title, style: TextStyle(color: Color(0xff706569), fontSize: 14.0),),
      backgroundColor: Colors.white,
    );
  }
}