import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

    var appBarTitle = AppLocalizations.of(context).sign_in;
    var signInButtonText = AppLocalizations.of(context).sign_in;
    var textFieldEmailForm = AppLocalizations.of(context).email;
    var textFieldPasswordForm = AppLocalizations.of(context).password;
    var textFieldEmailHint = AppLocalizations.of(context).email;
    var textFieldPasswordHint = AppLocalizations.of(context).password;
    var wrongEmailPasswordText =
        AppLocalizations.of(context).wrong_email_password;
    var wrongInputFormatText = AppLocalizations.of(context).wrong_input_format;

    return Scaffolds.basic(
      rowRate: [1, 8, 1],
      appBar: AppBars.basic(
        context: context,
        title: appBarTitle,
      ),
      body: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(height: 50),
            TextFormFields.basic(
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
            TextFormFields.basic(
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
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 25, 0, 25),
              child: Buttons.primary(
                active: !(isEmptyEmail || isEmptyPassword),
                text: signInButtonText,
                onPressed: () async {
                  isEmailValid = Valid.email(text: emailController.text);
                  if (isEmailValid) {
                    var user = await auth.signin(
                        emailController.text, passwordController.text);
                    isWrongEmailPassword = ("" == user.email);
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
      ]),
    );
  }
}
