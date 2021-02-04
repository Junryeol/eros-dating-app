import 'package:flutter/material.dart';

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
      TextInputType keyboardType}) {

    return Form(
        key: key,
        child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          Container(
            height: 14,
            width: double.infinity,
            child: Text(labelText,
                style: const TextStyle(
                    color:  const Color(0xff706569),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0),
                textAlign: TextAlign.left),
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
          SizedBox(height: 12),
        ]
      ),
    );
  }
}
