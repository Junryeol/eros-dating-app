import 'dart:developer';

import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/app_bars.dart';
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

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: onTapTab,
        elevation: 0,
        type: BottomNavigationBarType.fixed, // 4개 이상이면 어쩔 수 없음. shifting은 label색을 무조건 white로 바꿈
        selectedFontSize: 10,
        selectedLabelStyle: TextStyle(color: Skin.primary),
        unselectedFontSize: 10,
        unselectedLabelStyle: TextStyle(color: Skin.unselectedText),
        items: _tabList.asMap().map((i, e) => MapEntry(i, _buildBottomBarItem(e['icon'], e['label'], i))).values.toList()
      )
    );
  }

  BottomNavigationBarItem _buildBottomBarItem(IconData icon, String label, int index) {
    bool isCurrent = _tabIndex == index;
    return BottomNavigationBarItem(
      icon: Container(
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              Icon(icon, size: 28, color: isCurrent ? Skin.primary : Skin.unselectedText),
              SizedBox(height: 3)
            ],
          )
        )
      ),
      label: label,
      // backgroundColor: isCurrent ? Skin.white : Skin.unselected
    );
  }
}
