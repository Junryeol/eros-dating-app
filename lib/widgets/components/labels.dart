import 'package:flutter/material.dart';

class Labels {
  static basic(
      {BuildContext context,
        String labelText}) {

    return Container(
      height: 14,
      width: double.infinity,
      child: Text(labelText,
          style: const TextStyle(
              color:  const Color(0xff706569),
              fontWeight: FontWeight.w500,
              fontSize: 14.0),
          textAlign: TextAlign.left),
    );
  }
}
