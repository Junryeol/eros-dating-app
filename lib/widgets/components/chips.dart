import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chips {
  static basic({BuildContext context, List<String> tags, List<String> selectedTags, Function onSelected, double spacing = 8.0, double runSpacing = 4.0, double fontSize = 8.0, fontWeight = FontWeight.bold}){
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: <Widget>[..._generateTags(tags, selectedTags, onSelected, fontSize, fontWeight)],
    );
  }

  static _generateTags(tags, selectedTags, onSelected, fontSize, fontWeight) {
    return tags.map((tag) => _getChip(tag, selectedTags, onSelected, fontSize, fontWeight)).toList();
  }

  static _getChip(tag, selectedTags, onSelected, fontSize, fontWeight) {
    return ChoiceChip(
        selected: selectedTags.contains(tag),
        selectedColor: Color(0xfff2708f),
        disabledColor:Color(0xffd8d2d2),
        onSelected: (bool selected) {
          onSelected(tag, selected);
        },
        avatar:null,
        labelStyle: TextStyle(color: Color(0xff706569), fontSize: fontSize, fontWeight: fontWeight),
        label: Text(tag));
  }
}