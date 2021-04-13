import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/providers/auth.dart';
import 'package:eros/utils/valid.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/text_form_fields.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateAccountPage extends StatefulWidget {
  CreateAccountPage({Key key, this.pageController}) : super(key: key);

  PageController pageController;

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  GlobalKey<FormState> _keyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> _keyPassword = GlobalKey<FormState>();
  GlobalKey<FormState> _keyPasswordConfirm = GlobalKey<FormState>();
  FocusNode focusEmail, focusPassword, focusPasswordConfirm;

  bool _isEmailEmpty = true;
  bool _isPasswordEmpty = true;
  bool _passwordVisibility = false;
  bool _passwordConfirmVisibility = false;

  Color _emailPrefixColor, _passwordPrefixColor, _passwordConfirmPrefixColor;

  @override
  void initState() {
    super.initState();

    emailController.addListener(_onEmailChanged);
    passwordController.addListener(_onPasswordChanged);
    passwordConfirmController.addListener(()=>{});
    focusEmail = FocusNode();
    focusPassword = FocusNode();
    focusPasswordConfirm = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();

    focusEmail.dispose();
    focusPassword.dispose();
    focusPasswordConfirm.dispose();

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
      if (_requestEmailExists()) {
        setState(() {
          _emailPrefixColor = Skin.primary;
        });
        return tr("email_exists");
      }
      setState(() {
        _emailPrefixColor = null;
      });
      return null;
    }
    else {
      setState(() {
        _emailPrefixColor = Skin.primary;
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
        _passwordPrefixColor = Skin.primary;
      });
      return tr("password_none");
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
    });
  }

  bool _requestEmailExists() {
    // TODO: 휴대폰 인증번호 전송 request
    // response에 success/failed에 관련한 code 필요...?
    var result = {
      'code': 200
    }; // 여기서 call하고 response 저장
    // success code를 200이라 가정
    return result['code'] == 200;
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
    return Padding(
      padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
      child: Column(
        children: <Widget> [
          SizedBox(height: 48),
          Texts.basic(
            context: context,
            text: tr("create_account"),
            textAlign: TextAlign.center,
            height: 26,
            fontSize: 24,
            fontWeight: FontWeight.w700
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
          SizedBox(height: 36),
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
          SizedBox(height: 36),
          TextFormFields.basic(
            key: _keyPasswordConfirm,
            context: context,
            controller: passwordConfirmController,
            labelText: tr('password_confirm'),
            hintText: tr('password_hint'),
            prefixIcon: Icon(Icons.lock, color: _passwordConfirmPrefixColor,),
            suffixIcon: IconButton(
              icon: Icon(_passwordConfirmVisibility ? Icons.visibility_off : Icons.visibility),
              onPressed: _togglePasswordVisibility,
            ),
            obscureText: !_passwordConfirmVisibility,
            keyboardType: TextInputType.visiblePassword,
            focusNode: focusPassword,
            validator: _passwordValidator
          ),
          SizedBox(height: 36),
          Buttons.primary(
            context: context,
            text: tr('create_account'),
            active: !_isEmailEmpty & !_isPasswordEmpty,
            onPressed: _signIn
          ),
        ]
      ),
    );
  }
}