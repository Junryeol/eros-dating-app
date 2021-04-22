import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';

class I18n {
  static final locales = [
    const Locale('ko', 'KR'),
  ];

  static final path = 'assets/translations';
  static final fallbackLocale = Locale('ko', 'KR');

  static Future<List<String>> getList(Locale locale, String key) async {
    dynamic data = await rootBundle.loadString('$path/${locale.languageCode}-${locale.countryCode}.json')
        .then((jsonStr) => jsonDecode(jsonStr));
    for (var k in key.split('.')) {
      data = data[k];
    }
    return List<String>.from(data);
  }
}
