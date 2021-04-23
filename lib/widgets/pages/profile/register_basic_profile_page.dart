import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/pickers.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/segmented_controls.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:eros/providers/auth.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/text_form_fields.dart';

class RegisterBasicProfilePage extends StatefulWidget {
  RegisterBasicProfilePage({Key key, this.finish}) : super(key: key);

  final Function finish;

  @override
  _RegisterBasicProfilePageState createState() => _RegisterBasicProfilePageState();
}

class _RegisterBasicProfilePageState extends State<RegisterBasicProfilePage> {
  bool isEmptyNickname = true;
  bool isNicknameValid = false;

  TextEditingController nicknameController = TextEditingController();
  GlobalKey<FormState> nicknameFormKey = GlobalKey<FormState>();
  FocusNode nicknameFocus = FocusNode();
  Color _nicknamePrefixColor = null;

  String selectedGender = "female";

  Map<String, String> pickerText = {
    'job': tr('job_hint'),
    'birth': tr('date_of_birth_hint'),
    'height': tr('height_hint'),
    'body': tr('body_hint'),
    'residence': tr('residence_hint'),
    'religion': tr('religion_hint'),
    'smoking': tr('smoking_hint'),
    'drinking': tr('drinking_hint'),
  };

  @override
  void initState() {
    super.initState();
    nicknameController.addListener(() {
      var text = nicknameController.text;
      if ((text.length == 0) != isEmptyNickname) {
        setState(() {
          isEmptyNickname = text.length == 0;
        });
      }
    });
    nicknameFocus.addListener(_handleNicknameFocus);
  }

  @override
  void dispose() {
    nicknameController.dispose();
    nicknameFocus.removeListener(_handleNicknameFocus);
    super.dispose();
  }

  void _handleNicknameFocus() {
    if (!nicknameFocus.hasFocus) {
      nicknameFormKey.currentState.validate();
    }
  }

  void setValidNickname(bool value) {
    setState(() {
      isNicknameValid = value;
      _nicknamePrefixColor = value ? null : Skin.primary;
    });
  }

  String _nicknameValidator(String value) {
    var text = nicknameController.text.replaceAll(new RegExp(r"\s+"), '');
    nicknameController.value = TextEditingValue(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(offset: text.length)
      )
    );
    if (value.length < 2 || value.length > 10) {
      setValidNickname(false);
      return tr("nick_name_range");
    }
    // TODO: 중복확인
    // 
    setValidNickname(true);
    return null;
  }

  void setPickerData(String key, String value) {
    setState(() {
      pickerText[key] = value;
    });
  }

  Function submit (BuildContext context, Auth auth) {
    return () async {
      Navigator.pushNamed(context, '/home');
    };
  }

  void nextPage() {
    // TODO: 입력 정보 저장
    // 
    widget.finish();
  }

  @override
  Widget build(BuildContext context) {
    // Auth auth = Provider.of<Auth>(context);

    // TODO: 얘도 태그 불러오듯이 해야할까...?
    var jobList = ["하나","둘","셋"];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 32.0, right: 32.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 48),
            Texts.basic(
              context: context,
              height: 26,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              text: tr("register_basic_profile"),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Texts.secondary(
              context: context,
              height: 40,
              fontSize: 14,
              fontWeight: FontWeight.w300,
              text: tr("register_basic_profile_message"),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 48),
            SegmentedControls.basic(
              context: context,
              labelText: tr("gender"),
              children: {
                "female": Row(
                  children: <Widget>[
                    ImageIcon(AssetImage('assets/icons/female.png'), size: 24),
                    Text(tr("female")),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                "male": Row(
                  children: <Widget>[
                    ImageIcon(AssetImage('assets/icons/male.png'), size: 24),
                    Text(tr("male")),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              },
              onValueChanged: (gender) {
                setState(() {
                  selectedGender = gender;
                });
              },
              groupValue: selectedGender,
            ),
            SizedBox(height: 36),
            TextFormFields.basic(
              controller: nicknameController,
              labelText: tr("nick_name"),
              hintText: tr("nick_name_hint"),
              keyboardType: TextInputType.text,
              prefixIcon: Icon(Icons.person_outline, color: _nicknamePrefixColor),
              focusNode: nicknameFocus,
              key: nicknameFormKey,
              validator: _nicknameValidator,
            ),
            SizedBox(height: 36),
            Pickers.basic(
              context: context,
              labelText: tr("job"),
              hintText: pickerText['job'],
              icon: Icon(Icons.work),
              pickerdata:jobList,
              onConfirm:(List<String> values) {  } 
            ),
            SizedBox(height: 36),
            Pickers.date(
              context: context,
              labelText: tr("date_of_birth"),
              hintText: pickerText['birth'],
              icon: Icon(Icons.cake),
              onConfirm:(DateTime value) {}
            ),
            SizedBox(height: 36),
            Pickers.number(
              context: context,
              labelText: tr("height"),
              hintText: pickerText['height'],
              // TODO: Icon 대신 AssetImage가 들어갈 수 있도록
              icon: Icon(Icons.height),
              onConfirm:(List<int> values) {},
              begin: 140,
              end: 210,
              jump: 1,
            ),
            SizedBox(height: 36),
            Pickers.number(
              context: context,
              labelText: tr("body"),
              hintText: pickerText['body'],
              // TODO: Icon 대신 AssetImage가 들어갈 수 있도록
              icon: Icon(Icons.height),
              onConfirm:(List<int> values) {},
              begin: 140,
              end: 210,
              jump: 1,
            ),
            SizedBox(height: 36),
            Pickers.number(
              context: context,
              labelText: tr("residence"),
              hintText: pickerText['residence'],
              icon: Icon(Icons.location_on),
              onConfirm:(List<int> values) {},
              begin: 140,
              end: 210,
              jump: 1,
            ),
            SizedBox(height: 36),
            Pickers.number(
              context: context,
              labelText: tr("religion"),
              hintText: pickerText['religion'],
              icon: Icon(Icons.perm_contact_cal),
              onConfirm:(List<int> values) {},
              begin: 140,
              end: 210,
              jump: 1,
            ),
            SizedBox(height: 36),
            Pickers.number(
              context: context,
              labelText: tr("smoking"),
              hintText: pickerText['smoking'],
              icon: Icon(Icons.smoking_rooms),
              onConfirm:(List<int> values) {},
              begin: 140,
              end: 210,
              jump: 1,
            ),
            SizedBox(height: 36),
            Pickers.number(
              context: context,
              labelText: tr("drinking"),
              hintText: pickerText['drinking'],
              icon: Icon(Icons.liquor),
              onConfirm:(List<int> values) {},
              begin: 140,
              end: 210,
              jump: 1,
            ),
            SizedBox(height: 36),
            Buttons.primary(
              text: tr("next"),
              active: isNicknameValid,
              onPressed: nextPage,
            ),
            SizedBox(height: 84),
          ],
        )
      )
    );
  }
}
