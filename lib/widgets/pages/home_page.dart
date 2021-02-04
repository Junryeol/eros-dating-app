import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
    Auth auth = Provider.of<Auth>(context);
    auth.me();

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(auth.user.email),
            Text(auth.user.objectId),
            Buttons.primary(
              text: AppLocalizations.of(context).sign_out,
              onPressed: () async {
                await auth.signout(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
