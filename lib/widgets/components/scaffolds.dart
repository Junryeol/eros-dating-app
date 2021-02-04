import 'package:flutter/material.dart';

class Scaffolds {
  static basic({BuildContext context, List<int> rowRate, PreferredSizeWidget appBar, Widget body, Widget bottomNavigationBar}){
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Row(
        children: <Widget>[
          Expanded(
            flex: rowRate[0],
            child: Container(),
          ),
          Expanded(
            flex: rowRate[1],
            child: body,
          ),
          Expanded(
            flex: rowRate[2],
            child: Container(),
          )
        ],
      ),
    );
  }
}