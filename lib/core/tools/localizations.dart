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

  /// 根据语言类型加载本地各模块语言json文件
  Future<Localizations> load(String languageCode) async {
    try {
      String configJson = await rootBundle.loadString("locale/config.json");
      Map<String, dynamic> config = json.decode(configJson);

      for (String fileName in config['localizedModels']) {
        await _appendValues(fileName, languageCode);
      }
    } catch (e) {
      LogTools.log("Localizations", "load locale/config.json error $e");
    }
    return this;
  }

  /// 加载语言json内容填充到本地 [_localisedValues]
  _appendValues(String fileName, String languageCode) async {
    try {
      String jsonContent =
          await rootBundle.loadString("locale/$languageCode/$fileName.json");

      Map<String, dynamic> map = json.decode(jsonContent);
      if (map.isNotEmpty) {
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

  Future<void> loadFile(Locale locale) async {
    await load(locale);
    await Localizations.instance.load(locale.languageCode);
  }

  @override
  bool shouldReload(CommonLocalizationsDelegate old) => false;

  // 默认支持字符语言
  static const Locale _defaultLocale = Locale("zh");

  // 支持的字符语言集合
  static final List<String> _supportLanguageCodeList = ['zh'];

  /// 初始化本地化字符
  Locale initLocalizations({Locale? locale}) {
    // 支持的语言
    if (isSupported(locale ?? _defaultLocale)) {
      loadFile(locale ?? _defaultLocale);
      return locale ?? _defaultLocale;
    }

    // 不支持直接返回默认语言
    loadFile(_defaultLocale);
    return _defaultLocale;
  }
}
