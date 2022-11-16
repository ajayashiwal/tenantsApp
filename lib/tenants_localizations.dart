import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class TenantsLocalizations {
  TenantsLocalizations(this.locale);

  final Locale locale;

  static TenantsLocalizations? of(BuildContext context) {
    return Localizations.of<TenantsLocalizations>(context, TenantsLocalizations);
  }

  static final Map<String, Map<String, String>> _localizedValues = {};

  Future<bool> load() async {
    String data =
    await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> result = jsonDecode(data);
    Map<String, String> values = {};

    result.forEach((String key, dynamic value) {
      values[key] = value.toString();
    });
    _localizedValues[locale.languageCode] = values;
    return true;
  }

  String find(String key) {
    return _localizedValues[locale.languageCode]![key]??"";
  }
}

class TenantsLocalizationsDelegate
    extends LocalizationsDelegate<TenantsLocalizations> {
  const TenantsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'he'].contains(locale.languageCode);

  @override
  Future<TenantsLocalizations> load(Locale locale) async {
    TenantsLocalizations localizations = TenantsLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(TenantsLocalizationsDelegate old) => false;
}

