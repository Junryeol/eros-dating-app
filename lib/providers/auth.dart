import 'dart:developer';

import 'package:flutter/widgets.dart';

import 'package:eros/utils/rest.dart';
import 'package:eros/models/user.dart';

class Auth with ChangeNotifier {
  User user;
  Rest _rest;

  Auth() {
    user = User();
    _rest = Rest();
  }

  Future<User> me() async {
    var data = await _rest.get(
        path: "/users/me"
    );
    log("me: "+data.toString());
    if (data['code'] == 209){
      user = User();
    } else {
      user.email = data['email'];
      user.phone = data['phone'];
      user.objectId = data['objectId'];
    }
    return user;
  }

  Future<User> signin(email, password) async {
    var data = await _rest.get(
      path: "/login",
      params: {
        "username": email,
        "password": password,
      }
    );
    log("signin: "+data.toString());
    log("user: "+user.toString());

    if (!data.containsKey('error')){
      user.email = data['email'];
      user.phone = data['phone'];
      user.objectId = data['objectId'];
      notifyListeners();
    }

    return user;
  }

  Future<User> signup(email, password, phone) async {
    var data = await _rest.post(
      path:  "/users",
      data: {
        "username": email,
        "password": password,
        "email": email,
        "phone": phone,
      },
    );
    log("signup: "+data.toString());

    if (!data.containsKey('error')){
      await me();
      notifyListeners();
    }

    return user;
  }

  Future<User> signout({BuildContext context}) async {
    var data = await _rest.post(
      path:  "/logout",
    );
    _rest.removeSession();
    user = User();
    log("signout: "+data.toString());

    Navigator.pushNamed(context, '/init');
    return user;
  }
}
