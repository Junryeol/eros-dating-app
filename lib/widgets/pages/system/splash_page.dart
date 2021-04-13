import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key key}) : super(key: key);

  Widget _buildTitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <TextSpan> [
          TextSpan(
            text: "이상형 소개",
            style: TextStyle(
              color: Skin.primary,
              fontSize: 36.0,
              fontWeight: FontWeight.w700
            )
          ),
          TextSpan(
            text: "부터\n",
            style: TextStyle(
              color: Skin.grey,
              fontSize: 36.0,
              fontWeight: FontWeight.w700,
            )
          ),
          TextSpan(
            text: "오프라인 만남",
            style: TextStyle(
              color: Skin.primary,
              fontSize: 36.0,
              fontWeight: FontWeight.w700
            )
          ),
          TextSpan(
            text: "까지",
            style: TextStyle(
              color: Skin.grey,
              fontSize: 36.0,
              fontWeight: FontWeight.w700
            )
          )
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future preload = Future.wait([
      precacheImage(AssetImage("assets/images/logo.png"), context),
      precacheImage(AssetImage("assets/images/logo_and_text.png"), context)
    ]);
    return Scaffolds.basic(
      body: FutureBuilder(
        future: preload,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTitle(),
                SizedBox(height: 96),
                Image(
                  width: 237,
                  height: 163,
                  image: AssetImage('assets/images/logo.png')
                ),
                SizedBox(height: 96),
                Image(
                  width: 222.7,
                  height: 46,
                  image: AssetImage('assets/images/logo_and_text.png')
                ),
                // SvgPicture.asset("assets/images/logo.svg"),
              ],
            ),
          );
        }
      )
    );
  }
}
