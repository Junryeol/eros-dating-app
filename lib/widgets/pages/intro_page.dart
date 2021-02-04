import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      rowRate: [3, 14, 3],
      body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/images/intro.png"),
                SizedBox(height: 12),
                Texts.fitWidth(text: AppLocalizations
                    .of(context)
                    .hello_world, textAlign: TextAlign.left),
                SizedBox(height: 12),
                Buttons.primary(
                  text: AppLocalizations
                      .of(context)
                      .sign_up,
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
                    text: AppLocalizations
                        .of(context)
                        .sign_in,
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
