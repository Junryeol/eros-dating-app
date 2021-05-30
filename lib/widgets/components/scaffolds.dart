import 'package:flutter/material.dart';

class Scaffolds {
  static basic({BuildContext context, Key key, PreferredSizeWidget appBar, Widget body, Widget bottomNavigationBar, bool resizeToAvoidBottomInset}){
    return Scaffold(
      key: key,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: body,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
  static scroll({BuildContext context, Key key, PreferredSizeWidget appBar, Widget body, Widget bottomNavigationBar}){
    return Scaffold(
      key: key,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: SingleChildScrollView(child: body),
      );
  }
}