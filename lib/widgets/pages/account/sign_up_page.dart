import 'package:easy_localization/easy_localization.dart';
import 'package:eros/widgets/components/labels.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/segmented_controls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eros/providers/auth.dart';
import 'package:eros/utils/valid.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/text_form_fields.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool passObscureText = true;
  bool passValidObscureText = true;

  bool isEmptyEmail = true;
  bool isEmptyPassword = true;
  bool isEmptyPassValid = true;
  bool isEmptyPhone = true;
  bool isEmptyNickname = true;

  bool isWeakPassword = true;

  bool isEmailValid = false;
  bool isPhoneValid = false;
  bool isRegisteredEmail = false;
  bool isSamePassword = false;
  bool isNicknameValid = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passValidController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> passValidFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> nicknameFormKey = GlobalKey<FormState>();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode passValidFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode nicknameFocus = FocusNode();

  String selectedGender = "female";

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      var text = emailController.text;
      if ((text.length == 0) != isEmptyEmail) {
        setState(() {
          isEmptyEmail = text.length == 0;
        });
      }
    });
    passwordController.addListener(() {
      var text = passwordController.text;
      if ((text.length == 0) != isEmptyPassword) {
        setState(() {
          isEmptyPassword = text.length == 0;
        });
      }
    });
    passValidController.addListener(() {
      var text = passValidController.text;
      if ((text.length == 0) != isEmptyPassValid) {
        setState(() {
          isEmptyPassValid = text.length == 0;
        });
      }
    });
    phoneController.addListener(() {
      var text = phoneController.text;
      if ((text.length == 0) != isEmptyPhone) {
        setState(() {
          isEmptyPhone = text.length == 0;
        });
      }
    });
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
    emailController.dispose();
    passwordController.dispose();
    passValidController.dispose();
    phoneController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);

    var appBarTitle = tr("sign_up");
    var textFieldEmail = tr("email");
    var textFieldPassword = tr("password");
    var textFieldPhone = tr("phone");
    var textFieldNickname = tr("nick_name");
    var segmentedControlGender = tr("gender");
    var signUpButtonText = tr("sign_up");

    var wrongInputFormatText = tr("wrong_input_format");
    var registeredText = tr("registered");
    var weakPasswordText = tr("weak_password");
    var notMatchText = tr("not_match");

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
              child: TextFormFields.basic(
                controller: nicknameController,
                labelText: textFieldNickname,
                hintText: textFieldNickname,
                keyboardType: TextInputType.text,
                prefixIcon: Icon(Icons.person_outline),
                focusNode: nicknameFocus,
                onFieldSubmitted: (v){
                  FocusScope.of(context).requestFocus(emailFocus);
                },
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
              child: Labels.basic(
                labelText: segmentedControlGender
              )
            ),
            Container(
              margin: margin,
              child: SegmentedControls.basic(
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
                controller: emailController,
                labelText: textFieldEmail,
                hintText: textFieldEmail,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.person_outline),
                focusNode: emailFocus,
                onFieldSubmitted: (v){
                  FocusScope.of(context).requestFocus(passwordFocus);
                },
                key: emailFormKey,
                onChanged: (String val) {
                  emailFormKey.currentState.validate();
                },
                validator: (String val) {
                  if (!isEmailValid) {
                    isEmailValid = true;
                    return wrongInputFormatText;
                  } else if (isRegisteredEmail) {
                    isRegisteredEmail = false;
                    return registeredText;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: margin,
              child: TextFormFields.basic(
                controller: passwordController,
                labelText: textFieldPassword,
                hintText: textFieldPassword,
                keyboardType: TextInputType.visiblePassword,
                obscureText: passObscureText,
                prefixIcon: Icon(
                  Icons.lock,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    passObscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      passObscureText = !passObscureText;
                    });
                  },
                ),
                focusNode: passwordFocus,
                onFieldSubmitted: (v){
                  FocusScope.of(context).requestFocus(passValidFocus);
                },
                key: passwordFormKey,
                onChanged: (String val) {
                  passwordFormKey.currentState.validate();
                },
                validator: (String val) {
                  isWeakPassword = !Valid.password(text: val);
                  if (isWeakPassword) {
                    return weakPasswordText;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: margin,
              child: TextFormFields.basic(
                controller: passValidController,
                labelText: textFieldPassword,
                hintText: textFieldPassword,
                keyboardType: TextInputType.visiblePassword,
                obscureText: passValidObscureText,
                prefixIcon: Icon(
                  Icons.lock,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    passValidObscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      passValidObscureText = !passValidObscureText;
                    });
                  },
                ),
                focusNode: passValidFocus,
                onFieldSubmitted: (v){
                  FocusScope.of(context).requestFocus(phoneFocus);
                },
                key: passValidFormKey,
                onChanged: (String val) {
                  passValidFormKey.currentState.validate();
                },
                validator: (String val) {
                  isSamePassword = passwordController.text == val;
                  if (!isSamePassword) {
                    return notMatchText;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: margin,
              child: TextFormFields.basic(
                controller: phoneController,
                labelText: textFieldPhone,
                hintText: textFieldPhone,
                keyboardType: TextInputType.phone,
                prefixIcon: Icon(Icons.smartphone),
                focusNode: phoneFocus,
                onFieldSubmitted: (v){
                  submit(context, auth)();
                },
                key: phoneFormKey,
                onChanged: (String val) {
                  phoneFormKey.currentState.validate();
                },
                validator: (String val) {
                  if (!isPhoneValid) {
                    isPhoneValid = true;
                    return wrongInputFormatText;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: margin,
              child: Buttons.primary(
                text: signUpButtonText,
                active: !(isEmptyEmail || isEmptyPassword || isEmptyPassValid || isEmptyPhone || isNicknameValid),
                onPressed: submit(context, auth),
              ),
            ),
          ],
        )
    );


  }

  Function submit (BuildContext context, Auth auth) {
      return () async {
      isEmailValid = Valid.email(text: emailController.text);
      isPhoneValid = Valid.phone(text: phoneController.text);

      if (isEmailValid && isPhoneValid && isSamePassword) {
        var user = await auth.signup(email: emailController.text,
            password: passwordController.text, username: nicknameController.text, data: {"phone": phoneController.text,"gender":selectedGender});

        isRegisteredEmail = (user == {});
        if (!isRegisteredEmail) {
          Navigator.pushNamed(context, '/home');
        }
      }

      emailFormKey.currentState.validate();
      phoneFormKey.currentState.validate();
    };
  }

}
