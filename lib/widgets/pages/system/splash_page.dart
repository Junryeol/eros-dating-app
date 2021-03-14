import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 12),
            Text("splash"),
            // Image.asset("assets/images/logo_text.png"),
            SizedBox(height: 12),
            // SvgPicture.asset("assets/images/logo.svg"),
          ],
        ),
      ),
    );
  }
}
