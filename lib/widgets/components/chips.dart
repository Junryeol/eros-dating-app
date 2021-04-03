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
    return FilterChip(
        selected: selectedTags.contains(tag),
        selectedColor: Colors.blue.shade800,
        disabledColor: Colors.blue.shade400,
        onSelected: (bool selected) {
          onSelected(tag, selected);
        },
        labelStyle: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: fontWeight),
        label: Text(tag));
  }
}