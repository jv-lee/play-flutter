import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:playflutter/core/tools/log_tools.dart';

extension LocalizedStringExtension on String {
  String localized() {
    return Localizations.instance.text(this);
  }
}

class Localizations {
  static final Localizations _singleton = Localizations._internal();

  Localizations._internal();

  static Localizations get instance => _singleton;

  final Map<String, dynamic> _localisedValues = {};

  Future<Localizations> load(
      String languageCode, List<String> fileNames) async {
    for (String fileName in fileNames) {
      await _appendValues(fileName, languageCode);
    }
    return this;
  }

  _appendValues(String fileName, String languageCode) async {
    try {
      String jsonContent =
          await rootBundle.loadString("locale/$languageCode/$fileName.json");

      Map<String, dynamic> map = json.decode(jsonContent);
      if (map.isNotEmpty == true) {
        _localisedValues.addAll(map);
      }
    } catch (e) {
      LogTools.log(
          "Localizations", "load:${fileName}_$languageCode.json error $e");
    }
  }

  String text(String key) {
    var returnString = _localisedValues[key] ?? key;
    return returnString;
  }
}

class CommonLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  CommonLocalizationsDelegate._internal();

  static final CommonLocalizationsDelegate _instance =
      CommonLocalizationsDelegate._internal();

  static CommonLocalizationsDelegate getInstance() => _instance;

  @override
  bool isSupported(Locale locale) =>
      _supportLanguageCodeList.contains(locale.languageCode);

  @override
  SynchronousFuture<CupertinoLocalizations> load(
    Locale locale,
  ) {
    return SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations());
  }

  Future<void> loadFile(Locale locale, List<String> localizedModels) async {
    await load(locale);
    await Localizations.instance.load(locale.languageCode, localizedModels);
  }

  @override
  bool shouldReload(CommonLocalizationsDelegate old) => false;

  static const Locale _defaultLocale = Locale("zh");
  static final List<String> _supportLanguageCodeList = ['zh'];
  static final List<String> _localizedModels = [
    "common",
    "home",
    "account",
    "coin",
    "details",
    "me",
    "search",
    "settings",
    "square",
    "system",
    "todo"
  ];

  Locale initLocalizations({Locale? locale, List<String>? localizedModels}) {
    if (isSupported(locale ?? _defaultLocale)) {
      loadFile(locale ?? _defaultLocale, localizedModels ?? _localizedModels);
      return locale ?? _defaultLocale;
    }

    loadFile(_defaultLocale, localizedModels ?? _localizedModels);
    return _defaultLocale;
  }
}
