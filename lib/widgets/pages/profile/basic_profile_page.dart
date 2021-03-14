import 'package:easy_localization/easy_localization.dart';
import 'package:eros/widgets/components/pickers.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/segmented_controls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eros/providers/auth.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/text_form_fields.dart';

class BasicProfilePage extends StatefulWidget {
  BasicProfilePage({Key key}) : super(key: key);

  @override
  _BasicProfilePageState createState() => _BasicProfilePageState();
}

class _BasicProfilePageState extends State<BasicProfilePage> {
  bool isEmptyNickname = true;
  bool isNicknameValid = false;

  TextEditingController nicknameController = TextEditingController();

  GlobalKey<FormState> nicknameFormKey = GlobalKey<FormState>();

  FocusNode nicknameFocus = FocusNode();

  String selectedGender = "female";

  String jobText = tr("job");
  String dateOfBirthText = tr("date_of_birth");
  String heightText = tr("height");

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
  }

  @override
  void dispose() {
    nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);

    var appBarTitle = tr("profile_registration");
    var textFieldNickname = tr("nick_name");
    var segmentedControlGender = tr("gender");
    var jobLabelText = tr("job");
    var dateOfBirthLabelText = tr("date_of_birth");
    var heightLabelText = tr("height");

    var nextButtonText = tr("next");

    var registeredText = tr("registered");
    var jobList = ["하나","둘","셋"];
    var bodyList = jobList;
    var placeList = jobList;
    var religionList = jobList;
    var smokeList = jobList;
    var drinkList = jobList;

    var margin = const EdgeInsets.only(left: 40.0, right: 40.0);

    return Scaffolds.scroll(
        appBar: AppBars.basic(
          context: context,
          title: appBarTitle,
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: margin,
              child: SegmentedControls.basic(
                labelText: segmentedControlGender,
                children: {
                  "female": Row(
                    children: <Widget>[
                      Icon(Icons.mood),
                      Text(tr("female")),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  "male": Row(
                    children: <Widget>[
                      Icon(Icons.mood_bad),
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
            ),
            Container(
              margin: margin,
              child: TextFormFields.basic(
                controller: nicknameController,
                labelText: textFieldNickname,
                hintText: textFieldNickname,
                keyboardType: TextInputType.text,
                prefixIcon: Icon(Icons.person_outline),
                focusNode: nicknameFocus,
                key: nicknameFormKey,
                validator: (String val) {
                  if (!isNicknameValid) {
                    isNicknameValid = false;
                    return registeredText;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: margin,
              child: Pickers.basic(
                  context: context,
                  labelText: jobLabelText,
                  icon: Icon(Icons.work),
                  hintText: jobText,
                  pickerdata:jobList,
                  onConfirm:(List<String> values) {
                    setState(() {
                      jobText = values[0];
                    });
                  } ),
            ),
            Container(
              margin: margin,
              child: Pickers.date(
                  context: context,
                  labelText: dateOfBirthLabelText,
                  icon: Icon(Icons.cake),
                  hintText: dateOfBirthText,
                  onConfirm:(DateTime value) {
                    setState(() {
                      dateOfBirthText = value.toString().split(" ")[0];
                    });
                  } ),
            ),
            Container(
              margin: margin,
              child: Pickers.number(
                  context: context,
                  labelText: heightLabelText,
                  icon: Icon(Icons.cake),
                  hintText: heightText,
                  onConfirm:(List<int> values) {
                    setState(() {
                      heightText = values[0].toString();
                    });
                  },
                  begin: 140,
                  end: 210,
                  jump: 1,
              ),
            ),
            Container(
              margin: margin,
              child: Buttons.primary(
                text: nextButtonText,
                active: !(isNicknameValid),
                onPressed: submit(context, auth),
              ),
            ),
          ],
        )
    );
  }

  Function submit (BuildContext context, Auth auth) {
    return () async {
       Navigator.pushNamed(context, '/home');
    };
  }

}
