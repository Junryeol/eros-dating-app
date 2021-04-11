import 'package:easy_localization/easy_localization.dart';
import 'package:eros/utils/valid.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/text_form_fields.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';

class CertificationPage extends StatefulWidget {
  CertificationPage({Key key, this.pageController}) : super(key: key);

  final PageController pageController;

  @override
  _CertificationPageState createState() => _CertificationPageState();
}

class _CertificationPageState extends State<CertificationPage> {
  
  TextEditingController _phoneController = TextEditingController();
  GlobalKey<FormState> _keyPhone = GlobalKey<FormState>();
  FocusNode _focusPhone;
  bool _isPhoneEmpty = true;
  Color _phonePrefixColor;

  bool _isSendCertification = false;

  @override
  void initState() {
    super.initState();

    _phoneController.addListener(_onPhoneChanged);
    _focusPhone = FocusNode();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _focusPhone.dispose();

    super.dispose();
  }

  void _onPhoneChanged() {
    String input = _phoneController.text;
    bool cond = input.length == 0;
    if (cond ^ _isPhoneEmpty) {
      setState(() {
        _isPhoneEmpty = cond;
      });
    }
    // '-' 자동완성
    if (input.length > 8 && input[8] != '-') {
      _phoneController.value = TextEditingValue(
        text: input.substring(0, 8) + '-' + input.substring(8),
        selection: TextSelection.fromPosition(
          TextPosition(offset: input.length+1)
        )
      );
    }
    if (input.length > 3 && input[3] != '-') {
      _phoneController.value = TextEditingValue(
        text: input.substring(0, 3) + '-' + input.substring(3),
        selection: TextSelection.fromPosition(
          TextPosition(offset: input.length+1)
        )
      );
    }
    if (input.length == 4 && input[3] == '-') {
      _phoneController.value = TextEditingValue(
        text: input.substring(0, 3),
        selection: TextSelection.fromPosition(
          TextPosition(offset: input.length-1)
        )
      );
    }
    if (input.length == 9 && input[8] == '-') {
      _phoneController.value = TextEditingValue(
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
    } else {
      setState(() {
        _phonePrefixColor = Color(0xfff2708f);
      });
      return tr("phone_wrong");
    }
  }

  void _sendPhoneCertification() {
    if (!_keyPhone.currentState.validate()) {
      // 이메일 Focus
      FocusScope.of(context).requestFocus(_focusPhone);
    } else {
      var isSend = _requestForCertification();
      if (isSend) {
        setState(() {
          _isSendCertification = true;
        });
      } else {
        _showAlertDialog(tr('send_failed'), tr('send_failed_message'));
      }
    }
  }

  void _confirmPhoneCertification() {
    // TODO: 인증번호 입력칸 구현 다음에 진행
    // 인증번호가 동일할 시 다음 스텝으로 넘어감
    // 불일치면 _showAlertDialog
    widget.pageController.nextPage(duration: new Duration(milliseconds: 500), curve: Curves.ease);
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

  bool _requestForCertification() {
    // TODO: 휴대폰 인증번호 전송 request
    // response에 success/failed에 관련한 code 필요...?
    var result = {
      'code': 200
    }; // 여기서 call하고 response 저장
    // success code를 200이라 가정
    return result['code'] == 200;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 32, right: 32),
        child: Column(
          children: [
            SizedBox(height: 48),
            Texts.basic(
              context: context,
              text: tr("certification"),
              height: 26,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center
            ),
            SizedBox(height: 48),
            TextFormFields.basic(
              key: _keyPhone,
              context: context,
              controller: _phoneController,
              labelText: tr('phone_number'),
              hintText: tr('phone_hint'),
              prefixIcon: Icon(Icons.phone_android, color: _phonePrefixColor,),
              keyboardType: TextInputType.phone,
              focusNode: _focusPhone,
              validator: _phoneValidator,
            ),
            Container(
              child: SizedBox(height: 36)
            ),
            Material(
              child: Buttons.primary(
                context: context,
                text: tr('certification_send'),
                fontSize: 20,
                active: !_isPhoneEmpty,
                onPressed: _sendPhoneCertification
              ),
            ),
            SizedBox(height: 16),
            if (_isSendCertification)
              Material(
                child: Buttons.primary(
                  context: context,
                  fontSize: 20,
                  text: tr('certification_confirm'),
                  active: !_isPhoneEmpty,
                  onPressed: _confirmPhoneCertification
                )
              )
          ],
        ),
      )
    );
  }
}