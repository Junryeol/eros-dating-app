import 'package:flutter/material.dart';

class TextFields {
  static basic(
      {BuildContext context,
        TextEditingController controller,
        String hintText,
        Function onSubmitted,
        TextInputType keyboardType,
        Widget prefixIcon,
        Widget suffixIcon,
        FocusNode focusNode,
        bool autoFocus = false,
        int maxLines = 1}) {

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(color:  Color(0xffd8d2d2))
      ),
      focusNode: focusNode,
      autofocus: autoFocus,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
    );
  }
}
