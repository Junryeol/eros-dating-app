import 'package:flutter/material.dart';

class TextFields {
  static basic(
      {BuildContext context,
        TextEditingController controller,
        String hintText,
        Function onSubmitted,
        TextInputType keyboardType}) {

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
    );
  }
}
