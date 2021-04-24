import 'package:flutter/material.dart';

class TextFields {
  static basic(
      {BuildContext context,
        TextEditingController controller,
        String hintText,
        Function onSubmitted,
        int maxLines = 1,
        TextInputType keyboardType}) {

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
    );
  }
}
