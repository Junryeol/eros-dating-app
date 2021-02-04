import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
class PageIndicators{
  static circle({BuildContext context, int itemCount, ValueNotifier<int> currentPageNotifier, Function onPageSelected}){
    return CirclePageIndicator(
      itemCount: itemCount,
      currentPageNotifier: currentPageNotifier,
      onPageSelected: onPageSelected,
      selectedDotColor: Color(0xffffaec1),
      dotColor: Color(0xff888888) ,
    );
  }
}
