import 'package:flutter/material.dart';

import 'labels.dart';

class TextFormFields {
  static basic(
      {BuildContext context,
      TextEditingController controller,
      String labelText,
      String hintText,
      Widget prefixIcon,
      Widget suffixIcon,
      bool obscureText = false,
      FocusNode focusNode,
      Function onFieldSubmitted,
      Function validator,
      Function onChanged,
      Key key,
      TextInputType keyboardType
        , double height = 14.0, double width = double.infinity, double fontSize = 14.0, FontWeight fontWeight = FontWeight.w500
      }) {

    return Form(
        key: key,
        child: Column(
        children: <Widget>[
          Labels.basic(
              context: context,
              labelText: labelText,
            height: height,
            width: width,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          TextFormField(
            cursorColor: Color(0xff3a3a3f),
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintText: hintText,
              alignLabelWithHint: true,
            ),
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ]
      ),
    );
  }
}
