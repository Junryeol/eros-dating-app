import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SinglePlaygroundPage extends StatefulWidget {
  SinglePlaygroundPage({Key key}) : super(key: key);

  @override
  _SinglePlaygroundPageState createState() => _SinglePlaygroundPageState();
}

class _SinglePlaygroundPageState extends State<SinglePlaygroundPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(tr('single_playground')));
  }
}