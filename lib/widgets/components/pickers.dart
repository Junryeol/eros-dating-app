import 'package:flutter/material.dart';

import 'package:flutter_picker/flutter_picker.dart';

import 'buttons.dart';
import 'labels.dart';

class Pickers {
  static basic(
      {BuildContext context,
      String labelText,
      Icon icon,
      String hintText,
      List<String> pickerdata,
      Function onConfirm}) {

    icon = Icon(icon.icon, color:Color(0xff706569),);

    return Column(
      children: <Widget>[
        Labels.basic(context: context, labelText: labelText),
        Container(
          width: double.infinity,
          child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffd8d2d2), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Buttons.content(
                widget: Row(
                  children: <Widget>[
                    icon,
                    Container(
                        width: 120,
                        child: Text(
                          hintText,
                          style: const TextStyle(
                            color: const Color(0xff706569),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ))
                  ],
                ),
                onPressed: () {
                  Picker(
                      adapter:
                          PickerDataAdapter<String>(pickerdata: pickerdata),
                      onConfirm: (Picker picker, List value) {
                        onConfirm(picker.getSelectedValues());
                      }).showModal(context);
                },
              )),
        )
      ],
    );
  }

  static date(
      {BuildContext context,
        String labelText,
        Icon icon,
        String hintText,
        Function onConfirm}) {

    icon = Icon(icon.icon, color:Color(0xff706569),);

    return Column(
      children: <Widget>[
        Labels.basic(context: context, labelText: labelText),
        Container(
          width: double.infinity,
          child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffd8d2d2), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Buttons.content(
                widget: Row(
                  children: <Widget>[
                    icon,
                    Container(
                        width: 120,
                        child: Text(
                          hintText,
                          style: const TextStyle(
                            color: const Color(0xff706569),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ))
                  ],
                ),
                onPressed: () {
                  Picker(
                      adapter: DateTimePickerAdapter(),
                      onConfirm: (Picker picker, List value) {
                        onConfirm(
                            (picker.adapter as DateTimePickerAdapter).value);
                      }).showModal(context);
                },
              )),
        )
      ],
    );
  }

  static number(
      {BuildContext context,
        String labelText,
        Icon icon,
        String hintText,
        Function onConfirm,
        int begin,
        int end,
        int jump
      }) {

    icon = Icon(icon.icon, color:Color(0xff706569),);
    
    return Column(
      children: <Widget>[
        Labels.basic(context: context, labelText: labelText),
        Container(
          width: double.infinity,
          child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffd8d2d2), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Buttons.content(
                widget: Row(
                  children: <Widget>[
                    icon,
                    Container(
                        width: 120,
                        child: Text(
                          hintText,
                          style: const TextStyle(
                            color: const Color(0xff706569),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ))
                  ],
                ),
                onPressed: () {
                  Picker(
                      adapter: NumberPickerAdapter(data: [NumberPickerColumn(begin: begin, end: end, jump: jump)]),
                      onConfirm: (Picker picker, List value) {
                        onConfirm(picker.getSelectedValues());
                      }).showModal(context);
                },
              )),
        )
      ],
    );
  }

}
