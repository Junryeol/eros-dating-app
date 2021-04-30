import 'package:eros/configs/skin.dart';
import 'package:flutter/material.dart';

/// {data} parameter must have two keys.
/// 1. 'icon' key with [IconData] value. ex) Icons.close
/// 2. 'label' key with [String] value. ex) "LABEL"
class BottomTabBar extends StatelessWidget {
  BottomTabBar({
    Key key, 
    this.data, 
    this.currentIndex, 
    this.onTap,
    this.height = 64.0,

  }) : super(key: key);

  final List<Map<String, dynamic>> data;
  final int currentIndex;
  final Function(int) onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      // asMap() & MapEntry => for using index in map()
      children: data.asMap().map((i, e) {
        if (!e.containsKey('icon')) { throw FormatException("[data] parameter must have 'icon' key"); }
        else if(!e.containsKey('label')) { throw FormatException("[data] parameter must have 'label' key"); }
        else { return MapEntry(i, Expanded(child: buildTabBarItem(i, e['icon'], e['label']))); }
      }).values.toList(),
    );
  }

  Widget buildTabBarItem(int index, IconData icon, String label) {
    bool isCurrent = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        height: 64,
        color: isCurrent ? Skin.white : Skin.unselected,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28.0, color: isCurrent ? Skin.primary : Skin.unselectedText),
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  height: 1.2,
                  fontSize: 10.0,
                  color: isCurrent ? Skin.grey : Skin.unselectedText
                ),
              )
            ],
          )
      )
    );
  }
}