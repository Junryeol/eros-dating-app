import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/providers/auth.dart';
import 'package:eros/utils/valid.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/text_form_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignInDemoPage extends StatefulWidget {
  SignInDemoPage({Key key}) : super(key: key);

  @override
  _SignInDemoPageState createState() => _SignInDemoPageState();
}

class _SignInDemoPageState extends State<SignInDemoPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _keyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> _keyPassword = GlobalKey<FormState>();
  FocusNode focusEmail, focusPassword;

  bool _isEmailEmpty = true;
  bool _isPasswordEmpty = true;
  bool _passwordVisibility = false;

  @override
  void initState() {
    super.initState();

    emailController.addListener(_onEmailChanged);
    passwordController.addListener(_onPasswordChanged);
    focusEmail = FocusNode();
    focusPassword = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    focusEmail.dispose();
    focusPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolds.basic(
      body: _buildPage(context)
    );
  }

  void _onEmailChanged() {
    bool cond = emailController.text.length == 0;
    if (cond ^ _isEmailEmpty) {
      setState(() {
        _isEmailEmpty = cond;
      });
    }
  }

  void _onPasswordChanged() {
    bool cond = passwordController.text.length == 0;
    if (cond ^ _isPasswordEmpty) {
      setState(() {
        _isPasswordEmpty = cond;
      });
    }
  }

  String _emailValidator(String value) => Valid.email(text: value.trim()) ? null : tr("email_wrong");
  String _passwordValidator(String value) => Valid.password(text: value.trim()) ? null : tr("password_wrong");

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
    });
  }

  void _signIn() async {
    if (!_keyEmail.currentState.validate()) {
      // 이메일 Focus
      log(tr("email_wrong"));
      FocusScope.of(context).requestFocus(focusEmail);
    } else if (!_keyPassword.currentState.validate()) {
      // 비밀번호 Focus
      log(tr("password_wrong"));
      FocusScope.of(context).requestFocus(focusPassword);
    } else {
      log("signIn Success! ${_keyEmail.currentState} / ${_keyPassword.currentState}");
      // var user = await Auth().signin(email: email, password: password);
      // log(user.toString());
    }
  }

  Widget _buildPage(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
        child: Column(
          children: <Widget> [
            SizedBox(height: 120),
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Image(
                  width: 226,
                  height: 89,
                  image: AssetImage('assets/images/sign_in_logo.png')
                ),
              ),
            ),
            SizedBox(height: 48),
            TextFormFields.basic(
              key: _keyEmail,
              context: context,
              controller: emailController,
              labelText: tr('email'),
              hintText: tr('email_hint'),
              prefixIcon: Icon(Icons.person_outline),
              keyboardType: TextInputType.emailAddress,
              focusNode: focusEmail,
              validator: _emailValidator,
            ),
            SizedBox(height: 24),
            TextFormFields.basic(
              key: _keyPassword,
              context: context,
              controller: passwordController,
              labelText: tr('password'),
              hintText: tr('password_hint'),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(_passwordVisibility ? Icons.visibility_off : Icons.visibility),
                onPressed: _togglePasswordVisibility,
              ),
              obscureText: !_passwordVisibility,
              keyboardType: TextInputType.visiblePassword,
              focusNode: focusPassword,
              validator: _passwordValidator
            ),
            SizedBox(height: 24),
            Buttons.primary(
              context: context,
              text: tr('sign_in'),
              active: !_isEmailEmpty & !_isPasswordEmpty,
              onPressed: _signIn
            ),
            Container(
              margin: EdgeInsets.only(top: 27),
              height: 13,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    tr('sign_up_question'),
                    style: TextStyle(fontSize: 12),
                  ),
              )
            ),
            Container(
                margin: EdgeInsets.only(top: 6),
                height: 16,
                child: Align(
                    alignment: Alignment.center,
                    child: Buttons.transparency(
                    context: context,
                    text: tr('sign_up'),
                    onPressed: ()=>{Navigator.pushNamed(context, "/sign_up")}
                    //style: TextStyle(fontSize: 14),
                  ),
              )
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                  children: <Widget> [
                    Buttons.transparency(
                      context: context,
                      text: tr('email_find'),
                      onPressed: () => Navigator.pushNamed(context, "/find_email"),
                    ),
                    Divider(),
                    Buttons.transparency(
                      context: context,
                      text: tr('password_find'),
                      onPressed: () => Navigator.pushNamed(context, "/reset_password"),
                    )
                  ],
                )
              )
            ),
            SizedBox(height: 48)
          ]
        ),
    );
  }
}