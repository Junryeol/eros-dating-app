import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/providers/auth.dart';
import 'package:eros/utils/valid.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/dialogs.dart';
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

  bool _isEmailEmpty = true, _isEmailValid = false;
  bool _isPasswordEmpty = true, _isPasswordValid = false;
  bool _isPasswordConfirmEmpty = true, _isPasswordMatch = false;
  bool _passwordVisibility = false;
  bool _passwordConfirmVisibility = false;

  Color _emailPrefixColor, _passwordPrefixColor, _passwordConfirmPrefixColor;

  @override
  void initState() {
    super.initState();

    emailController.addListener(_onEmailChanged);
    // passwordController.addListener(_onPasswordChanged);
    // passwordConfirmController.addListener(_onPasswordConfirmChanged);
    focusEmail = FocusNode();
    focusPassword = FocusNode();
    focusPassword.addListener(_onPasswordFocusOut);
    focusPasswordConfirm = FocusNode();
    focusPasswordConfirm.addListener(_onPasswordConfirmFocusOut);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();

    focusEmail.dispose();
    focusPassword.removeListener(_onPasswordFocusOut);
    focusPassword.dispose();
    focusPasswordConfirm.removeListener(_onPasswordConfirmFocusOut);
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
    _isEmailValid = _keyEmail.currentState.validate();
  }

  // void _onPasswordChanged() {
  //   bool cond = passwordController.text.length == 0;
  //   if (cond ^ _isPasswordEmpty) {
  //     setState(() {
  //       _isPasswordEmpty = cond;
  //     });
  //   }
  //   // _isPasswordValid = _keyPassword.currentState.validate();
  // }
  void _onPasswordFocusOut() {
    setState(() {
      _isPasswordValid = _keyPassword.currentState.validate();
    });
  }

  // void _onPasswordConfirmChanged() {
  //   bool cond = passwordConfirmController.text.length == 0;
  //   if (cond ^ _isPasswordConfirmEmpty) {
  //     setState(() {
  //       _isPasswordConfirmEmpty = cond;
  //     });
  //   }
  //   // _isPasswordMatch = _keyPasswordConfirm.currentState.validate();
  // }
  void _onPasswordConfirmFocusOut() {
    setState(() {
      _isPasswordMatch = _keyPasswordConfirm.currentState.validate();
    });
  }

  // 임시로 회원가입 때와 동일하게
  String _emailValidator(String value) {
    var textvalue = emailController.text;
    if (textvalue.isEmpty) {
      setState(() {
        _emailPrefixColor = null;
      });
      return null;
    }
    if (Valid.email(text: textvalue.trim())) {
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
      return tr("email_wrong");
    }
  }

  String _passwordValidator(String value) {
    var textvalue = passwordController.text;
    if (textvalue.isEmpty) {
      setState(() {
        _isPasswordEmpty = true;
        _passwordPrefixColor = null;
      });
      return null;
    }
    if (Valid.password(text: textvalue.trim())) {
      setState(() {
        _isPasswordEmpty = false;
        _passwordPrefixColor = null;
      });
      return null;
    }
    else {
      setState(() {
        _isPasswordEmpty = false;
        _passwordPrefixColor = Skin.primary;
      });
      return tr("password_valid");
    }
  }

  String _passwordConfirmValidator(String value) {
    var textvalue = passwordConfirmController.text;
    if (textvalue.isEmpty) {
      setState(() {
        _isPasswordConfirmEmpty = true;
        _passwordConfirmPrefixColor = null;
      });
      return null;
    }
    if (passwordController.text == textvalue) {
      setState(() {
        _isPasswordConfirmEmpty = false;
        _passwordConfirmPrefixColor = null;
      });
      return null;
    }
    else {
      setState(() {
        _isPasswordConfirmEmpty = false;
        _passwordConfirmPrefixColor = Skin.primary;
      });
      return tr("password_mismatch");
    }
  }

  bool _requestEmailExists() {
    // TODO: 이메일 등록 유무 request
    // response에 success/failed에 관련한 code 필요...?
    var result = {
      'code': 200
    }; // 여기서 call하고 response 저장
    // success code를 200이라 가정 (=있는거?)
    return result['code'] != 200;
  }

  bool _requestSignUp() {
    // TODO: 회원가입 request(tag: users)
    var result = {
      'code': 200
    }; // 여기서 call하고 response 저장
    return result['code'] == 200;
  }

  void _signUp() async {
    // TODO: 로그인 API로 POST
    // Code가 200말고도 [미등록 이메일, 비밀번호 불일치] 등이 필요함
    // 혹은 error 와 message의 내용이 뭐뭐 있는지
    // var result = await Auth().signin(email: emailController.text, password: passwordController.text);
    // if (result['code'] == 200) {
    //  Navigator.pushName(context, '/home');
    // }
    
    // 아래는 임시
    // if (!_keyEmail.currentState.validate()) {
    //   // 이메일 Focus
    //   FocusScope.of(context).requestFocus(focusEmail);
    // } else if (!_keyPassword.currentState.validate()) {
    //   // 비밀번호 Focus
    //   FocusScope.of(context).requestFocus(focusPassword);
    // } else {
    //   log("signIn Success! ${_keyEmail.currentState} / ${_keyPassword.currentState}");
    // }
    _showAlertDialog(emailController.text, tr("sign_up_confirm")).whenComplete(() => Navigator.pushReplacementNamed(context, '/home'));
  }

  Future<void> _showAlertDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialogs.alert(
          context: context,
          title: title,
          content: message,
          OnPressed: () => Navigator.of(context).pop()
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: _content(context)
    );
  }

  Widget _content(BuildContext context) {
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
            obscureText: !_passwordVisibility,
            keyboardType: TextInputType.visiblePassword,
            focusNode: focusPassword,
            validator: _passwordValidator,
          ),
          SizedBox(height: 36),
          TextFormFields.basic(
            key: _keyPasswordConfirm,
            context: context,
            controller: passwordConfirmController,
            labelText: tr('password_confirm'),
            hintText: tr('password_hint'),
            prefixIcon: Icon(Icons.lock, color: _passwordConfirmPrefixColor,),
            obscureText: !_passwordConfirmVisibility,
            keyboardType: TextInputType.visiblePassword,
            focusNode: focusPasswordConfirm,
            validator: _passwordConfirmValidator
          ),
          SizedBox(height: 36),
          Material(
            child: Buttons.primary(
              context: context,
              text: tr('create_account'),
              active: !_isEmailEmpty & !_isPasswordEmpty & !_isPasswordConfirmEmpty & _isEmailValid & _isPasswordValid & _isPasswordMatch,
              onPressed: _signUp
            )
          ),
          Expanded(child: Container(color: Colors.transparent))
        ]
      ),
    );
  }
}