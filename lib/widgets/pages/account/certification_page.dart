import 'package:easy_localization/easy_localization.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';

class CertificationPage extends StatefulWidget {
  CertificationPage({Key key, this.pageController}) : super(key: key);

  final PageController pageController;

  @override
  _CertificationPageState createState() => _CertificationPageState();
}

class _CertificationPageState extends State<CertificationPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32, right: 32),
      child: Column(
        children: [
          Texts.basic(
            context: context,
            text: tr("certification"),
            height: 26,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center
          )
        ],
      ),
    );
  }
}