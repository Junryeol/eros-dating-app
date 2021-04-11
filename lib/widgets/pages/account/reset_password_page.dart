import 'package:easy_localization/easy_localization.dart';
import 'package:eros/utils/valid.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/labels.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/text_form_fields.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _keyEmail = GlobalKey<FormState>();
  FocusNode focusEmail;
  bool _isEmailEmpty = true;
  Color _emailPrefixColor;

  @override
  void initState() {
    super.initState();

    emailController.addListener(_onEmailChanged);
    focusEmail = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    focusEmail.dispose();

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
      return tr("email_wrong");
    }
  }

  void _sendEmailForResetPassword() {
    if (!_keyEmail.currentState.validate()) {
      // 이메일 Focus
      FocusScope.of(context).requestFocus(focusEmail);
    } else {
      var isSend = _requestForResetPassword();
      if (isSend) {
        _showAlertDialog(tr('send_complete'), tr('password_reset_send'));
      }
    }
  }

  bool _requestForResetPassword() {
    // TODO: 비밀번호 재설정 관련 request
    // response에 success/failed에 관련한 code 필요...?
    var result = {
      'code': 200
    }; // 여기서 call하고 response 저장
    // success code를 200이라 가정
    return result['code'] == 200;
  }

  Future<void> _showAlertDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              color: Color(0xff252528),
              fontSize: 20,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0.0),
          content: Text(
                  message,
                  style: TextStyle(
                    color: Color(0xff9a9297),
                    height: 1.7,
                    fontSize: 14,
                    letterSpacing: 0.28,
                    fontWeight: FontWeight.w300
                  ),
                ),
          actions: <Widget>[
            TextButton(
              child: Text(
                tr('confirm'),
                style: TextStyle(
                  color: Color(0xfff2708f),
                  fontSize: 20,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700
                ),
              ),
              onPressed: () => Navigator.of(context).pop()
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolds.basic(
      appBar: AppBars.basic(
        context: context,
        title: tr("password_find"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
        child: Column(
          children: [
            SizedBox(height: 52),
            Texts.basic(
              context: context,
              height: 26,
              text: tr("password_reset"),
              textAlign: TextAlign.center,
              fontSize: 24.0,
              fontWeight: FontWeight.w700
            ),
            SizedBox(height: 12),
            Text(
              tr("password_reset_guide"),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffd8d2d2),
                height: 1.7,
                fontSize: 14.0,
                fontWeight: FontWeight.w300
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
            SizedBox(height: 36),
            Buttons.primary(
              context: context,
              text: tr('send'),
              active: !_isEmailEmpty,
              onPressed: _sendEmailForResetPassword
            ),
          ],
        )
      )
    );
  }
}