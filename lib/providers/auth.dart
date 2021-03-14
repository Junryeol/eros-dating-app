import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';

import 'package:crypto/crypto.dart';

import 'package:eros/utils/rest.dart';

class Auth with ChangeNotifier {
  Map<String, dynamic> user;
  Rest _rest;

  Auth() {
    user = {};
    _rest = Rest();
  }

  Future<Map<String, dynamic>> me() async {
    var res = await _rest.get(
        path: "/users/me"
    );
    log("me: "+res.toString());
    if (res['code'] == 209){
      user = {};
    } else {
      user = res;
    }
    return user;
  }

  Future<Map<String, dynamic>> signin({String email, String password}) async {
    var digest = sha256.convert(utf8.encode(password)).toString();

    var res = await _rest.get(
      path: "/login",
      params: {
        "email": email,
        "password": digest,
      }
    );
    log("signin: "+res.toString());
    log("user: "+user.toString());

    if (!res.containsKey('error')){
      user = res;
      notifyListeners();
    }

    return user;
  }

  Future<Map<String, dynamic>> signup({String email, String password, String username, Map<String, String> data}) async {
    var digest = sha256.convert(utf8.encode(password)).toString();

    data["email"] = email;
    data["password"] = digest;
    data["username"] = username;

    var res = await _rest.post(
      path:  "/users",
      data: data,
    );
    log("signup: "+res.toString());

    if (!res.containsKey('error')){
      await me();
      notifyListeners();
    }

    return user;
  }

  Future<Map<String, dynamic>> signout({BuildContext context}) async {
    var res = await _rest.post(
      path:  "/logout",
    );
    _rest.removeSession();
    user = {};
    log("signout: "+res.toString());

    Navigator.pushNamed(context, '/intro');
    return user;
  }

  Future<Map<String, dynamic>> update({BuildContext context}) async {
    var res = await _rest.post(
      path:  "/logout",
    );
    _rest.removeSession();
    user = {};
    log("signout: "+res.toString());

    Navigator.pushNamed(context, '/intro');
    return user;
  }

}
