import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:playflutter/core/tools/log_tools.dart';

/// 本地化字符扩展函数
/// 通过字符key.localized() 获取本地化字符
extension LocalizedStringExtension on String {
  String localized() {
    return Localizations.instance.text(this);
  }
}

/// 本地化字符文件处理
class Localizations {
  static final Localizations _singleton = Localizations._internal();

  Localizations._internal();

  static Localizations get instance => _singleton;

  // 本地字符缓存
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

/// 本地化代理加载器
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

  // 默认支持字符语言
  static const Locale _defaultLocale = Locale("zh");

  // 支持的字符语言集合
  static final List<String> _supportLanguageCodeList = ['zh'];

  // 需要加载的字符模块名
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

  /// 初始化本地化字符
  Locale initLocalizations({Locale? locale, List<String>? localizedModels}) {
    if (isSupported(locale ?? _defaultLocale)) {
      loadFile(locale ?? _defaultLocale, localizedModels ?? _localizedModels);
      return locale ?? _defaultLocale;
    }

    loadFile(_defaultLocale, localizedModels ?? _localizedModels);
    return _defaultLocale;
  }
}
