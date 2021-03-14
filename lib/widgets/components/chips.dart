import 'package:flutter/material.dart';

class Chips {
  static basic({BuildContext context, List<String> tags, List<String> selectedTags, Function onSelected}){
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      children: <Widget>[..._generateTags(tags, selectedTags, onSelected)],
    );
  }

  static _generateTags(tags, selectedTags, onSelected) {
    return tags.map((tag) => _getChip(tag, selectedTags, onSelected)).toList();
  }

  static _getChip(tag, selectedTags, onSelected) {
    return FilterChip(
        selected: selectedTags.contains(tag),
        selectedColor: Colors.blue.shade800,
        disabledColor: Colors.blue.shade400,
        onSelected: (bool selected) {
          onSelected(tag, selected);
        },
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        label: Text(tag));
  }
}