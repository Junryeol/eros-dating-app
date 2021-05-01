import 'dart:developer';

import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/bottom_tab_bar.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/pages/home/choice_page.dart';
import 'package:eros/widgets/pages/home/daily_recommendation_page.dart';
import 'package:eros/widgets/pages/home/message_page.dart';
import 'package:eros/widgets/pages/home/request_manage_page.dart';
import 'package:eros/widgets/pages/home/single_playground_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:eros/providers/auth.dart';
import 'package:eros/widgets/components/buttons.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StatefulWidget> _pages; 
  List<Map<String, dynamic>> _tabList;
  int _tabIndex;

  @override
  void initState() { 
    super.initState();
    _pages = [
      DailyRecommendatonPage(key: Key('daily_recommendation')),
      ChoicePage(key: Key('choice')),
      RequestManagePage(key: Key('request_manage')),
      MessagePage(key: Key('message')),
      SinglePlaygroundPage(key: Key('single_playground'))
    ];
    _tabList = [
      { 'icon': Icons.favorite_border, 'label': tr('daily_recommendation') },
      { 'icon': Icons.touch_app_outlined, 'label': tr('choice') },
      { 'icon': Icons.playlist_add_check, 'label': tr('request_manage') },
      { 'icon': Icons.textsms_outlined, 'label': tr('message') },
      { 'icon': Icons.attractions, 'label': tr('single_playground') },
    ];
    _tabIndex = 0;
  }

  void onTapTab(int index) {
    setState(() { _tabIndex = index; });
    
  }

  @override
  Widget build(BuildContext context) {
    // Auth auth = Provider.of<Auth>(context);
    // auth.me();
    // var email = auth.user["email"];
    // var objectId = auth.user["objectId"];

    StatefulWidget _currentPage = _pages[_tabIndex];
    
    return Scaffolds.scroll(
      appBar: AppBars.basic(
        context: context,
        title: _tabList[_tabIndex]['label'],
        fontSize: 16.0
      ),
      body: _currentPage,
      // BottomNavigationBar로는 디자인대로 구현 불가능 (가장 큰 이유는 배경색 변경)
      bottomNavigationBar: BottomTabBar(
        data: _tabList, 
        currentIndex: _tabIndex,
        onTap: onTapTab,
      )
    );
  }
}
