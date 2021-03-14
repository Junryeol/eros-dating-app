import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eros/providers/auth.dart';
import 'package:eros/utils/valid.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/text_form_fields.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool obscureText = true;

  bool isEmptyEmail = true;
  bool isEmptyPassword = true;
  bool isEmailValid = true;
  bool isWrongEmailPassword = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

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
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);

    var appBarTitle = tr("sign_in");
    var signInButtonText = tr("sign_in");
    var textFieldEmailForm = tr("email");
    var textFieldPasswordForm = tr("password");
    var textFieldEmailHint = tr("email");
    var textFieldPasswordHint = tr("password");
    var wrongEmailPasswordText = tr("wrong_email_password");
    var wrongInputFormatText = tr("wrong_input_format");

    var margin = const EdgeInsets.only(left: 20.0, right: 20.0);

    return Scaffolds.basic(
      appBar: AppBars.basic(
        context: context,
        title: appBarTitle,
      ),
      body: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Container(
              margin: margin,
              child: TextFormFields.basic(
                controller: emailController,
                labelText: textFieldEmailForm,
                hintText: textFieldEmailHint,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.person_outline),
                key: emailFormKey,
                onChanged: (String val) {
                  emailFormKey.currentState.validate();
                },
                validator: (String val) {
                  if (!isEmailValid) {
                    isEmailValid = true;
                    return wrongInputFormatText;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: margin,
              child: TextFormFields.basic(
                controller: passwordController,
                labelText: textFieldPasswordForm,
                hintText: textFieldPasswordHint,
                keyboardType: TextInputType.visiblePassword,
                obscureText: obscureText,
                prefixIcon: Icon(
                  Icons.lock,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
                key: passwordFormKey,
                onChanged: (String val) {
                  passwordFormKey.currentState.validate();
                },
                validator: (String val) {
                  if (isWrongEmailPassword) {
                    isWrongEmailPassword = false;
                    return wrongEmailPasswordText;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: margin,
              child: Buttons.primary(
                active: !(isEmptyEmail || isEmptyPassword),
                text: signInButtonText,
                onPressed: () async {
                  isEmailValid = Valid.email(text: emailController.text);
                  if (isEmailValid) {
                    var user = await auth.signin(
                        email: emailController.text, password: passwordController.text);
                    isWrongEmailPassword = (user == {});
                    if (!isWrongEmailPassword) {
                      Navigator.pushNamed(context, '/home');
                    }
                  }
                  emailFormKey.currentState.validate();
                  passwordFormKey.currentState.validate();
                },
              ),
            ),
          ],
        ),
    );
  }
}
