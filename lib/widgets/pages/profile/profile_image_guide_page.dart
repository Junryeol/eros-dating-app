import 'package:easy_localization/easy_localization.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';

class ProfileImageGuidePage extends StatefulWidget {
  ProfileImageGuidePage({Key key}) : super(key: key);

  @override
  _ProfileImageGuidePageState createState() => _ProfileImageGuidePageState();
}

class _ProfileImageGuidePageState extends State<ProfileImageGuidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffolds.scroll(
      context: context,
      appBar: AppBars.basic(
        context: context,
        title: tr("guide")
      ),
      body: Texts.basic(text: tr('guide'))      
    );
  }
}