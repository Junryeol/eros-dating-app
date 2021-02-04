import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'package:eros/configs/globals.dart' as globals;

class Rest {
  // ignore: non_constant_identifier_names
  final String _PARSE_APP_ID = 'APPLICATION_ID';

  // ignore: non_constant_identifier_names
  final String _PARSE_APP_URL = 'https://192.168.0.6/parse';
  // final String _PARSE_APP_URL = 'http://192.168.0.6:1337/parse';

  IOClient _http;

  Rest() {
    var ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    _http = IOClient(ioc);
  }

  Map<String, String> _header() {
    try {
      String session = globals.prefs.get("session");
      if (session != null) {
        return {
          "X-Parse-Application-Id": _PARSE_APP_ID,
          "X-Parse-Session-Token": session,
        };
      }
    }
    catch(e) {
      print(e);
    }
    return {"X-Parse-Application-Id": _PARSE_APP_ID,};
  }

  Map<String, dynamic> _json2object(response) {
    Map<String, dynamic> data = jsonDecode(response.body);
    if (data.containsKey("sessionToken")) {
      globals.prefs.setString("session", data["sessionToken"]);
      data.remove("sessionToken");
    }
    return data;
  }

  String _url(path, params) {
    if (params == null){
      return _PARSE_APP_URL + path;
    } else {
      return _PARSE_APP_URL + path + '?' + Uri(queryParameters: params).query;
    }
  }

  void removeSession(){
    globals.prefs.setString("session", null);
  }

  Future<bool> health() async {
    Response response = await _http.get(
      _PARSE_APP_URL + "/health",
      headers: _header(),
    );
    print(response.statusCode);
    if (response.statusCode < 300 && _json2object(response)['status'] == "ok"){
      return true;
    }
    return false;
  }

  Future<Map<String, dynamic>> get({String path, Map<String, dynamic> params}) async {
    Response response = await _http.get(
      _url(path, params),
      headers: _header(),
    );
    return _json2object(response);
  }

  Future<Map<String, dynamic>> post({String path,  Map<String, dynamic> data, Map<String, dynamic> params}) async {
    Response response;
    if (data == null){
      response = await _http.post(
        _url(path, params),
        headers: _header(),
      );
    } else {
      response = await _http.post(
        _url(path, params),
        headers: _header(),
        body: json.encode(data),
      );
    }
    return _json2object(response);
  }
}