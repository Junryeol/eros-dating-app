import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/texts.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffolds.basic(
      body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/images/intro.png"),
                SizedBox(height: 12),
                Texts.fitWidth(text: tr("hello_world"), textAlign: TextAlign.left),
                SizedBox(height: 12),
                Buttons.primary(
                  text: tr("sign_up"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign_up');
                  },
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Buttons.transparency(
                    text: tr("sign_in"),
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_in');
                    },
                  ),
                )
              ],
            ),
          ]),
    );
  }
}
