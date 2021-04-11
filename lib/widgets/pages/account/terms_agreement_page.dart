import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/checkboxs.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:eros/widgets/pages/account/terms_detail_page.dart';
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
  List<Map<String, dynamic>> checkList = [
    { "id": "terms_service", "check": false },
    { "id": "terms_personal", "check": false },
    { "id": "terms_location", "check": false },
    { "id": "terms_marketing", "check": false },
  ]; // 데이터 보낼때 약관동의 날짜도 포함해야함

  @override
  Widget build(BuildContext context) {
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
                Checkboxs.circle(
                  context: context,
                  value: checkList.every((element) => element['check']),
                  onChanged: (value) {
                    setState(() {
                      checkList.forEach((e) {
                        e['check'] = value;
                        return e;
                      });
                    });
                  },
                  widget: SizedBox()
                )
                // CircularCheckBox(
                //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //   activeColor: Color(0xfff2708f),
                //   value: checkList.every((element) => element['check']),
                //   onChanged: (value) {
                //     log(value.toString());
                //     setState(() {
                //       checkList.forEach((e) {
                //         e['check'] = value;
                //         return e;
                //       });
                //     });
                //   }
                // )
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
          ...checkList.map((e) => new _TermAgreement(
            checkValue: e['check'], 
            onChange: (value) {
              setState(() {
                checkList[checkList.indexOf(e)]['check'] = value;
              });
            },
            isRequired: true,
            textId: e['id'],
          )),
          SizedBox(height: 36),
          Buttons.primary(
            context: context,
            active: checkList.every((element) => element['check']),
            height: 64,
            text: tr("next"),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            onPressed: () { widget.pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease); }
          )
        ],
      ),
    );
  }
}

class _TermAgreement extends StatelessWidget {
  _TermAgreement({
    Key key, 
    @required this.checkValue, 
    @required this.onChange, 
    this.isRequired = true,
    this.textId = "약관 동의"
  }) : super(key: key);

  final bool checkValue;
  final Function onChange;
  bool isRequired;
  String textId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
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
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, "/terms_detail", arguments: TermsDetailArguments(textId)),
                child: Text(
                  tr(textId),
                  style: TextStyle(
                    color: checkValue ? Color(0xff706569) : Color(0xffd8d2d2),
                    fontSize: 14,
                  ),
                )
              )
            )
          ),
          Checkboxs.circle(
            context: context,
            value: checkValue,
            onChanged: (value) => onChange(value),
            widget: SizedBox(),
          )
        ]
      )
    );
  }

}