import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChoicePage extends StatefulWidget {
  ChoicePage({Key key}) : super(key: key);

  @override
  _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(tr('choice')));
  }
}