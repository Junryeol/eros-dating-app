import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DailyRecommendatonPage extends StatefulWidget {
  DailyRecommendatonPage({Key key}) : super(key: key);

  @override
  _DailyRecommendatonPageState createState() => _DailyRecommendatonPageState();
}

class _DailyRecommendatonPageState extends State<DailyRecommendatonPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(tr('daily_recommendation')));
  }
}