import 'package:flutter/material.dart';

class NavigationBars {
  static bottom({BuildContext context, Map<String, Widget> items, int currentIndex = 0, Function onTap}) {
    var bottomItems = [];
    items.forEach((label,icon) => bottomItems.add(BottomNavigationBarItem(
      label: label,
      icon: icon,
    )));

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.grey,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.60),
      currentIndex: currentIndex, //현재 선택된 Index
      onTap: onTap,
      items: bottomItems,
    );
  }
}
