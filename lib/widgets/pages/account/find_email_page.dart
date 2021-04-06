import 'package:easy_localization/easy_localization.dart';
import 'package:eros/utils/valid.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/text_form_fields.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FindEmailPage extends StatefulWidget {
  FindEmailPage({Key key}) : super(key: key);

  @override
  _FindEmailPageState createState() => _FindEmailPageState();
}

class _FindEmailPageState extends State<FindEmailPage> {

  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> _keyPhone = GlobalKey<FormState>();
  FocusNode focusPhone;
  bool _isPhoneEmpty = true;
  Color _phonePrefixColor;

  @override
  void initState() {
    super.initState();

    phoneController.addListener(_onPhoneChanged);
    focusPhone = FocusNode();
  }

  @override
  void dispose() {
    phoneController.dispose();
    focusPhone.dispose();

    super.dispose();
  }

  void _onPhoneChanged() {
    String input = phoneController.text;
    bool cond = input.length == 0;
    if (cond ^ _isPhoneEmpty) {
      setState(() {
        _isPhoneEmpty = cond;
      });
    }
    // '-' 자동완성
    if (input.length > 8 && input[8] != '-') {
      phoneController.value = TextEditingValue(
        text: input.substring(0, 8) + '-' + input.substring(8),
        selection: TextSelection.fromPosition(
          TextPosition(offset: input.length+1)
        )
      );
    }
    if (input.length > 3 && input[3] != '-') {
      phoneController.value = TextEditingValue(
        text: input.substring(0, 3) + '-' + input.substring(3),
        selection: TextSelection.fromPosition(
          TextPosition(offset: input.length+1)
        )
      );
    }
    if (input.length == 4 && input[3] == '-') {
      phoneController.value = TextEditingValue(
        text: input.substring(0, 3),
        selection: TextSelection.fromPosition(
          TextPosition(offset: input.length-1)
        )
      );
    }
    if (input.length == 9 && input[8] == '-') {
      phoneController.value = TextEditingValue(
        text: input.substring(0, 8),
        selection: TextSelection.fromPosition(
          TextPosition(offset: input.length-1)
        )
      );
    }
  }

  String _phoneValidator(String value) {
    if (Valid.phone(text: value.trim())) {
      setState(() {
        _phonePrefixColor = null;
      });
      return null;
    } else if (!_requestForPhoneExist()) {
      setState(() {
        _phonePrefixColor = Color(0xfff2708f);
      });
      return tr("phone_none");
    } else {
      setState(() {
        _phonePrefixColor = Color(0xfff2708f);
      });
      return tr("phone_wrong");
    }
  }

  void _sendPhoneForFindEmail() {
    if (!_keyPhone.currentState.validate()) {
      // 이메일 Focus
      FocusScope.of(context).requestFocus(focusPhone);
    } else {
      var isSend = _requestForFindEmail();
      if (isSend) {
        _showAlertDialog();
      }
    }
  }

  bool _requestForFindEmail() {
    // TODO: 문자 발송 관련 request
    // response에 success/failed에 관련한 code 필요...?
    var result = {
      'code': 200
    }; // 여기서 call하고 response 저장
    // success code를 200이라 가정
    return result['code'] == 200;
  }

  bool _requestForPhoneExist() {
    // TODO: 휴대폰 가입유무 검사 관련 request
    // response에 success/failed에 관련한 code 필요...?
    var result = {
      'code': 200
    }; // 여기서 call하고 response 저장
    // success code를 200이라 가정
    return result['code'] == 200;
  }

  // 이 Alert 내용이 아직 없어서 비밀번호 재설정 화면과 동일한 상태
  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            tr('send_complete'),
            style: TextStyle(
              color: Color(0xff252528),
              fontSize: 20,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0.0),
          content: Text(
                  tr('password_reset_send'),
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
        title: tr("email_find"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
        child: Column(
          children: [
            SizedBox(height: 52),
            Texts.basic(
              context: context,
              height: 26,
              text: tr("email_find_title"),
              textAlign: TextAlign.center,
              fontSize: 24.0,
              fontWeight: FontWeight.w700
            ),
            SizedBox(height: 12),
            Text(
              tr("email_find_guide"),
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
              key: _keyPhone,
              context: context,
              controller: phoneController,
              labelText: tr('phone'),
              hintText: tr('phone_hint'),
              prefixIcon: Icon(Icons.phone_android, color: _phonePrefixColor,),
              keyboardType: TextInputType.phone,
              focusNode: focusPhone,
              validator: _phoneValidator,
            ),
            SizedBox(height: 36),
            Buttons.primary(
              context: context,
              text: tr('send'),
              active: !_isPhoneEmpty,
              onPressed: _sendPhoneForFindEmail
            ),
          ],
        )
      )
    );
  }
}