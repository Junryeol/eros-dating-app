
import 'package:easy_localization/easy_localization.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/pages/account/certification_page.dart';
import 'package:eros/widgets/pages/account/terms_agreement_page.dart';
import 'package:eros/widgets/pages/system/intro_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolds.basic(
      appBar: AppBars.basic(
        context: context,
        title: tr("sign_up")
      ),
      body: Column(
        children: [
          Container(height: 4, color: Color(0xffffeeee),),
          Expanded(
            flex: 1,
            child: PageView(
              controller: _pageController,
              children: [
                TermsAgreementPage(pageController: _pageController),
                CertificationPage(pageController: _pageController),
              ],
              physics: new NeverScrollableScrollPhysics(),
            )
          )
        ]
      )
    );
  }

}
