import 'package:easy_localization/easy_localization.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FindEmailPage extends StatefulWidget {
  FindEmailPage({Key key}) : super(key: key);

  @override
  _FindEmailPageState createState() => _FindEmailPageState();
}

class _FindEmailPageState extends State<FindEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffolds.basic(
      appBar: AppBars.basic(
        context: context,
        title: tr("email_find"),
      ),
    );
  }
}