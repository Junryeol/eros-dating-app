import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/i18n.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/linear_progresses.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/pages/profile/profile_tag_select_page.dart';
import 'package:eros/widgets/pages/profile/register_basic_profile_page.dart';
import 'package:eros/widgets/pages/profile/upload_profile_image_page.dart';
import 'package:flutter/material.dart';

class RegisterProfileScreen extends StatefulWidget {
  RegisterProfileScreen({Key key}) : super(key: key);

  @override
  _RegisterProfileScreenState createState() => _RegisterProfileScreenState();
}

class _RegisterProfileScreenState extends State<RegisterProfileScreen> {
  bool isDebugMode = true;
  bool isPageLoaded = false;
  PageController _pageController;
  int _index = 1;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _pages.addAll([
      RegisterBasicProfilePage(finish: nextPage),
      UploadProfileImagePage(finish: nextPage),
    ]);
    Future.delayed(Duration.zero, () {
      Future.wait([
        buildTagPage("charming_point"),
        buildTagPage("ideal_type"),
        buildTagPage("hobbies")
      ]).then((value) => setState(() { 
        _pages.insertAll(1, value);
        isPageLoaded = true; 
      }));
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<Widget> buildTagPage(String id) async {
    var tags = await I18n.getList(context.locale, "tag_list.$id");
    return ProfileTagSelectPage(id: id, tags: tags, finish: nextPage);
  }

  void nextPage() {
    _pageController.nextPage(duration: new Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolds.basic(
      context: context,
      // resizeToAvoidBottomInset: false,
      appBar: AppBars.basic(
        context: context,
        title: tr("register_profile")
      ),
      body: isPageLoaded ? Column(
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