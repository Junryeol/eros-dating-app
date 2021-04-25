import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:eros/providers/auth.dart';
import 'package:eros/widgets/components/buttons.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Auth auth = Provider.of<Auth>(context);
    // auth.me();
    // var email = auth.user["email"];
    // var objectId = auth.user["objectId"];

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text("snoopykim0@gmail.com"),
            Text("objectId는 뭐여"),
            Buttons.primary(
              text: tr("sign_out"),
              onPressed: () {
                // auth.signout(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
