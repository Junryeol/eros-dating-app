
import 'package:easy_localization/easy_localization.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/linear_progresses.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/pages/account/certification_page.dart';
import 'package:eros/widgets/pages/account/create_account_page.dart';
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
  int _index = 1;

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
    List<Widget> _pages = [
      TermsAgreementPage(pageController: _pageController),
      CertificationPage(pageController: _pageController),
      CreateAccountPage(pageController: _pageController),
    ];

    return Scaffolds.basic(
      context: context,
      resizeToAvoidBottomInset: false,
      appBar: AppBars.basic(
        context: context,
        title: tr("sign_up")
      ),
      body: Column(
        children: [
          LinearProgresses.basic(
            context: context,
            value: _index / _pages.length
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: _pages,
              physics: new NeverScrollableScrollPhysics(),
              onPageChanged: (pageIndex) {
                setState(() {
                  _index = pageIndex+1;
                });
              },
            )
          ),
        ]
      )
    );
  }

}
