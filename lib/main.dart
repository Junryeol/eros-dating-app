import 'package:eros/widgets/pages/system/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/PickerLocalizationsDelegate.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:eros/configs/init.dart';
import 'package:eros/configs/i18n.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/configs/route.dart';
import 'package:eros/providers/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized().then((value) {
    runApp(
      EasyLocalization(
        supportedLocales: I18n.locales,
        path: I18n.path,
        fallbackLocale: I18n.fallbackLocale,
        saveLocale: false,
        child: App()
      )
    );
  });
  
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 스플래시 화면 내 이미지 precache
    precacheImage(AssetImage('assets/images/logo_and_text.png'), context);
    precacheImage(AssetImage('assets/images/logo.png'), context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (_) => Auth()),
      ],
      child: MaterialApp(
        title: "Eros",
        localizationsDelegates: context.localizationDelegates + [PickerLocalizationsDelegate.delegate],
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: Skin.light(),
        darkTheme: Skin.dark(),
        initialRoute: '/',
        routes: RoutePath.routes(context),
        home: FutureBuilder(
          future: Init.init(),
          builder: Init.page,
        ),
      )
    );
  }
}
