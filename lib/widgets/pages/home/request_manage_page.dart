import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RequestManagePage extends StatefulWidget {
  RequestManagePage({Key key}) : super(key: key);

  @override
  _RequestManagePageState createState() => _RequestManagePageState();
}

class _RequestManagePageState extends State<RequestManagePage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(tr('request_manage')));
  }
}