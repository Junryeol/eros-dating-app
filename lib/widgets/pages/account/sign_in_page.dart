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

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _keyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> _keyPassword = GlobalKey<FormState>();
  FocusNode focusEmail, focusPassword;

  bool _isEmailEmpty = true;
  bool _isPasswordEmpty = true;
  bool _passwordVisibility = false;

  Color _emailPrefixColor = null;
  Color _passwordPrefixColor = null;

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

  // 임시로 회원가입 때와 동일하게
  String _emailValidator(String value) {
    if (Valid.email(text: value.trim())) {
      setState(() {
        _emailPrefixColor = null;
      });
      return null;
    }
    else {
      setState(() {
        _emailPrefixColor = Color(0xfff2708f);
      });
      return tr("email_none");
    }
  }

  String _passwordValidator(String value) {
    if (Valid.password(text: value.trim())) {
      setState(() {
        _passwordPrefixColor = null;
      });
      return null;
    }
    else {
      setState(() {
        _passwordPrefixColor = Color(0xfff2708f);
      });
      return tr("password_none");
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
    });
  }

  void _signIn() async {
    // TODO: 로그인 API로 POST
    // Code가 200말고도 [미등록 이메일, 비밀번호 불일치] 등이 필요함
    // 혹은 error 와 message의 내용이 뭐뭐 있는지
    // var result = await Auth().signin(email: emailController.text, password: passwordController.text);
    // if (result['code'] == 200) {
    //  Navigator.pushName(context, '/home');
    // }
    
    // 아래는 임시
    if (!_keyEmail.currentState.validate()) {
      // 이메일 Focus
      FocusScope.of(context).requestFocus(focusEmail);
    } else if (!_keyPassword.currentState.validate()) {
      // 비밀번호 Focus
      FocusScope.of(context).requestFocus(focusPassword);
    } else {
      log("signIn Success! ${_keyEmail.currentState} / ${_keyPassword.currentState}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolds.basic(
      body: _buildPage(context),
      resizeToAvoidBottomInset: false,
    );
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
              prefixIcon: Icon(Icons.person_outline, color: _emailPrefixColor,),
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
              prefixIcon: Icon(Icons.lock, color: _passwordPrefixColor,),
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
                    // 왜 안뜨지...;;
                    text: tr('sign_up'),
                    onPressed: ()=>{Navigator.pushNamed(context, "/sign_up")},
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
                    Divider(), // TODO: 컴포넌트 완성되면 대체
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