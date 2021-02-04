import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:eros/providers/auth.dart';
import 'package:eros/utils/valid.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/text_form_fields.dart';
import 'package:eros/widgets/components/page_indicators.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<List<Widget>> items;
  PageController pageController = PageController();
  ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);

  bool passObscureText = true;
  bool passValidObscureText = true;

  bool isEmptyEmail = true;
  bool isEmptyPassword = true;
  bool isEmptyPassValid = true;
  bool isEmptyPhone = true;

  bool isWeakPassword = true;

  bool isEmailValid = false;
  bool isPhoneValid = false;
  bool isRegisteredEmail = false;
  bool isSamePassword = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passValidController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> passValidFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode passValidFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();

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
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passValidController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);

    var appBarTitle = AppLocalizations.of(context).sign_up;
    var textFieldEmail = AppLocalizations.of(context).email;
    var textFieldPassword = AppLocalizations.of(context).password;
    var textFieldPhone = AppLocalizations.of(context).phone;
    var signUpButtonText = AppLocalizations.of(context).sign_up;

    var wrongInputFormatText =
        AppLocalizations.of(context).wrong_input_format;
    var registeredEmailText =
        AppLocalizations.of(context).registered_email;
    var weakPasswordText =
        AppLocalizations.of(context).weak_password;
    var notMatchText =
        AppLocalizations.of(context).not_match;

    items = <List<Widget>>[
      <Widget>[
        TextFormFields.basic(
          controller: emailController,
          labelText: textFieldEmail,
          hintText: textFieldEmail,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icon(Icons.person_outline),
          focusNode: emailFocus,
          onFieldSubmitted: (v){
            FocusScope.of(context).requestFocus(passwordFocus);
            currentPageNotifier.value = 1;
            pageController.jumpToPage(1);
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
              return registeredEmailText;
            }
            return null;
          },
        ),
      ],
      <Widget>[
        TextFormFields.basic(
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
        TextFormFields.basic(
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
            currentPageNotifier.value = 2;
            pageController.jumpToPage(2);
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
      ],
      <Widget>[
        TextFormFields.basic(
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
      ]
    ];

    return Scaffold(
        appBar: AppBars.basic(
          context: context,
          title: appBarTitle,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              child: PageView.builder(
                  itemCount: items.length,
                  controller: pageController,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: <Widget>[
                                  SizedBox(height: 50),
                                ] +
                                items[index],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        )
                      ],
                    );
                  },
                  onPageChanged: (int index) {
                    currentPageNotifier.value = index;
                  }),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  PageIndicators.circle(
                    itemCount: items.length,
                    currentPageNotifier: currentPageNotifier,
                    onPageSelected: (int index) {
                      currentPageNotifier.value = index;
                      pageController.jumpToPage(index);
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 25, 0, 25),
                          child: Buttons.primary(
                            text: signUpButtonText,
                            active: !(isEmptyEmail || isEmptyPassword || isEmptyPassValid || isEmptyPhone),
                            onPressed: submit(context, auth),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      )
                    ],
                  ),
                ])
          ],
        ));
  }

  Function submit (BuildContext context, Auth auth) {
      return () async {
      isEmailValid = Valid.email(text: emailController.text);
      isPhoneValid = Valid.phone(text: phoneController.text);

      if (isEmailValid && isPhoneValid && isSamePassword) {
        var user = await auth.signup(emailController.text,
            passwordController.text, phoneController.text);

        isRegisteredEmail = ("" == user.email);
        if (!isRegisteredEmail) {
          Navigator.pushNamed(context, '/home');
        }
      }

      emailFormKey.currentState.validate();
      phoneFormKey.currentState.validate();
    };
  }

}
