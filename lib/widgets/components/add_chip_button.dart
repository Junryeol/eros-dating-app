import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/text_fields.dart';
import 'package:flutter/material.dart';

class AddChipButton extends StatefulWidget {
  AddChipButton({Key key, @required this.buttonText, this.hintText='', this.onSubmit=_defaultSubmit}) : super(key: key);

  final String buttonText;
  final String hintText;
  final Function(String) onSubmit;

  @override
  _AddChipButtonState createState() => _AddChipButtonState();

  static void _defaultSubmit(String str) {}
}

class _AddChipButtonState extends State<AddChipButton> {
  TextEditingController controller = TextEditingController();
  bool inputActive = false;

  void onSubmitted() {
    setState((){ inputActive = false; });
    widget.onSubmit(controller.text.trim());
    controller.clear();
  }

  @override
  void dispose() {
    controller.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return inputActive ? 
      TextFields.basic(
        context: context,
        keyboardType: TextInputType.text,
        controller: controller,
        hintText: widget.hintText,
        prefixIcon: InkWell(
          child: Icon(Icons.add, size: 20),
          onTap: onSubmitted,
        ),
        autoFocus: true,
        onSubmitted: (value) { onSubmitted(); },
      ) : Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Skin.primary,
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: InkWell(
            onTap: () => setState(() { inputActive = true; }),
            child: Padding(
              padding: EdgeInsets.fromLTRB(6, 4, 10, 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: 20, color: Skin.white),
                  SizedBox(width: 6),
                  Text(
                    widget.buttonText,
                    style: TextStyle(
                      height: 13.0/12.0,
                      color: Skin.white,
                      fontSize: 12.0,
                      letterSpacing: 0.24,
                    ),
                    textAlign: TextAlign.left,
                  )
                ]
              )
            )
          )
        )
      );
  }
}