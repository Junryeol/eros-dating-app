import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eros/providers/auth.dart';
import 'package:eros/widgets/components/logos.dart';

class SignOutPage extends StatefulWidget {
  SignOutPage({Key key}) : super(key: key);

  @override
  _SignOutPageState createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage> {
  Auth _auth;

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<Auth>(context);

    Navigator.pushNamed(context, '/init');
    return Scaffold(
      body: Center(
        child: Logos.bigLogo(size: 400),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _auth.signout();
  }
}
