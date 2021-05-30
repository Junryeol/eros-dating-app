import 'package:flutter/material.dart';

class Sliders {
  static basic({BuildContext context, RangeValues range, int divisions, double value, String label, Function onChanged}) {
    return Slider(
      value: value,
      min: range.start,
      max: range.end,
      divisions: divisions,
      label: label,
      onChanged: onChanged,
    );
  }

  static range({BuildContext context, RangeValues range, int divisions, RangeValues values, RangeLabels labels, Function onChanged}) {
    return RangeSlider(
      values: values,
      min: range.start,
      max: range.end,
      divisions: divisions,
      labels: labels,
      onChanged: onChanged,
    );
  }
}
