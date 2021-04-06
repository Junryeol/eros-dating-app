import 'package:circular_check_box/circular_check_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/checkboxs.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eros/providers/auth.dart';

class TermsAgreementPage extends StatefulWidget {
  TermsAgreementPage({Key key, this.pageController}) : super(key: key);

  final PageController pageController;

  @override
  _TermsAgreementPageState createState() => _TermsAgreementPageState();
}

class _TermsAgreementPageState extends State<TermsAgreementPage> {
  Auth _auth;

  List<bool> check = [false,false,false,false]; // 데이터 보낼때 약관동의 날짜도 포함해야함

  Widget _renderAgreementRow({ @required bool checkValue, @required Function onChange, bool isRequired = true, String text = "약관 동의" }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "["+ (isRequired ? tr("required") : tr("option"))+"]",
          style: TextStyle(
            color: Color(0xfff2708f),
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.28
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 3),
            child: Texts.basic(
              context: context,
              height: 18,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              text: text
            )
          )
        ),
        CircularCheckBox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeColor: Color(0xfff2708f),
          value: checkValue,
          onChanged: (value) {
            onChange(value);
          }
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<Auth>(context);

    return Container(
      padding: EdgeInsets.only(left: 32, right: 32),
      child: Column(
        children: <Widget>[
          SizedBox(height: 48),
          Texts.basic(
            context: context,
            text: tr("terms_agreement"),
            height: 26,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center
          ),
          SizedBox(height: 48),
          Container(
            height: 48,
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  child: Texts.basic(
                    context: context,
                    height: 18,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    text: tr("agree_all")
                  )
                ),
                CircularCheckBox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: Color(0xfff2708f),
                  value: check[0],
                  onChanged: (value) {
                    setState(() { check[0] = value; });
                  }
                )
              ]
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff9a9297),
                width: 1
              )
            )
          ),
          // TODO: 반복문이 너무 마렵다...
          SizedBox(height: 12),
          _renderAgreementRow(
            isRequired: true,
            text: tr("terms_service"),
            checkValue: check[0], 
            onChange: (value) {
              setState(() { check[0] = value; });
            }
          ),
          SizedBox(height: 12),
          _renderAgreementRow(
            isRequired: true,
            text: tr("terms_personal"),
            checkValue: check[1], 
            onChange: (value) {
              setState(() { check[1] = value; });
            }
          ),
          SizedBox(height: 12),
          _renderAgreementRow(
            isRequired: true,
            text: tr("terms_location"),
            checkValue: check[2], 
            onChange: (value) {
              setState(() { check[2] = value; });
            }
          ),
          SizedBox(height: 12),
          _renderAgreementRow(
            isRequired: true,
            text: tr("terms_marketing"),
            checkValue: check[3], 
            onChange: (value) {
              setState(() { check[3] = value; });
            }
          ),
          SizedBox(height: 36),
          Buttons.primary(
            context: context,
            active: true,
            height: 64,
            text: tr("next"),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            onPressed: () { widget.pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.ease); }
          )
        ],
      ),
    );
  }
}
