import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eros/configs/init.dart';
import 'package:eros/configs/i18n.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/configs/route.dart';
import 'package:eros/providers/auth.dart';

void main() async {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (_) => Auth()),
      ],
      child: MaterialApp(
        title: "Eros",
        localizationsDelegates: I18n.delegates,
        supportedLocales: I18n.locales,
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
