import 'package:circular_check_box/circular_check_box.dart';
import 'package:eros/widgets/components/checkboxs.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eros/providers/auth.dart';

class TermsDetailPage extends StatefulWidget {
  TermsDetailPage({Key key}) : super(key: key);

  @override
  _TermsDetailPageState createState() => _TermsDetailPageState();
}

class _TermsDetailPageState extends State<TermsDetailPage> {
  Auth _auth;

  List<bool> check = [false,false,false,false]; // 데이터 보낼때 약관동의 날짜도 포함해야함

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<Auth>(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircularCheckBox(
                   value: check[0],
                onChanged: (value) {
                  setState(() {
                    check[0] = value;
                  });
                },
              ),
              Text("dfgsdfgsdf")
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          Checkboxs.basic(
            value:check[0],
            onChanged: (value) {
              setState(() {
              check[0] = value;
              });
            },
            widget: Row(children: [Text("dfgsdfgsdf")],)
          )
        ],
      ),
    );
  }
}
