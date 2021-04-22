import 'package:flutter/material.dart';

class TextFields {
  static basic(
      {BuildContext context,
        TextEditingController controller,
        String hintText,
        Function onSubmitted,
        TextInputType keyboardType,
        Widget prefixIcon,
        FocusNode focusNode,
        bool autoFocus}) {

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: prefixIcon,
        hintText: hintText,
      ),
      focusNode: focusNode,
      autofocus: autoFocus,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
    );
  }
}
