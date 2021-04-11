import 'package:flutter/material.dart';

import 'labels.dart';

class TextFormFields {
  static basic(
      {BuildContext context,
      TextEditingController controller,
      String labelText,
      String hintText,
      Icon prefixIcon,
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
            validator: (String value) {
              var result = validator(value);
              print(result);
              if (result != null){
                prefixIcon = Icon(prefixIcon.icon, color:Color(0xfff2708f),);
              }
              else {
                prefixIcon = Icon(prefixIcon.icon);
              }
              return result;
            },
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintText: hintText,
              alignLabelWithHint: true,
              errorStyle: TextStyle(
                color: Color(0xfff2708f)
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xfff2708f)),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xfff2708f), width: 2.0),
              ),
            ),
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ]
      ),
    );
  }
}
