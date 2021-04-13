import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:eros/configs/globals.dart' as globals;
import 'package:eros/configs/route.dart';
import 'package:eros/utils/rest.dart';

class Init {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    globals.prefs = await SharedPreferences.getInstance();

    loadResource();
    // TODO: 디바이스 네트워크 체크 추가 필요
    var rest = Rest();
    // globals.health = await rest.health();
  }

  static Widget page(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return RoutePath.routes(context)['/index'](context);
      if (globals.health) {
        if (globals.prefs.get("session") != null) {
          if (globals.prefs.get("terms") != null) {
            return RoutePath.routes(context)['/home'](context);
          } else {
            return RoutePath.routes(context)['/terms'](context);
          }
        } else {
          return RoutePath.routes(context)['/intro'](context);
        }
      } else {
        return RoutePath.routes(context)['/error'](context);
      }
    }
    return RoutePath.routes(context)['/splash'](context);
  }

  static loadResource(){
  }
}