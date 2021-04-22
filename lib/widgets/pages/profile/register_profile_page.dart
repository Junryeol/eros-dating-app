import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/i18n.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/linear_progresses.dart';
import 'package:eros/widgets/components/page_indicators.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/pages/profile/profile_tag_select_page.dart';
import 'package:flutter/material.dart';

class RegisterProfilePage extends StatefulWidget {
  RegisterProfilePage({Key key}) : super(key: key);

  @override
  _RegisterProfilePageState createState() => _RegisterProfilePageState();
}

class _RegisterProfilePageState extends State<RegisterProfilePage> {
  bool isDebugMode = true;
  PageController _pageController;
  int _index = 1;

  List<Widget> _pages = [];

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

  void addPage(int index, String id, List<String> tags) {
    Widget newPage = ProfileTagSelectPage(id: id, tags: tags, finish: nextPage);
    setState(() {
      _pages.insert(index, newPage);
    });
  }

  void nextPage() {
    _pageController.nextPage(duration: new Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    if (_pages.length == 0) {
      I18n.getList(context.locale, "tag_list.charming_point").then((value) => addPage(0, "charming_point", value));
      I18n.getList(context.locale, "tag_list.ideal_type").then((value) => addPage(1, "ideal_type", value));
      I18n.getList(context.locale, "tag_list.hobbies").then((value) => addPage(2, "hobbies", value));
    }
    return Scaffolds.basic(
      context: context,
      resizeToAvoidBottomInset: false,
      appBar: AppBars.basic(
        context: context,
        title: tr("register_profile")
      ),
      body: _pages.length == 3 ? Column(
        children: [
          LinearProgresses.basic(
            context: context,
            value: _index / _pages.length
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: _pages,
              physics: isDebugMode ? null : new NeverScrollableScrollPhysics(),
              onPageChanged: (pageIndex) {
                setState(() {
                  _index = pageIndex+1;
                });
              },
            ) 
          ),
        ]
      ): Center(
        child: CircularProgressIndicator()
      )
    );
  }
}