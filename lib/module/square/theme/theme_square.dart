// ignore_for_file: library_private_types_in_public_api
import 'package:playflutter/core/tools/localizations.dart';

/// @author jv.lee
/// @date 2023/1/31
/// @description 广场模块 资源引用类
class ThemeSquare {
  static _Constants constants = _Constants();
  static _Strings strings = _Strings();
}

class _Constants {
  String squareList = "local:square-list";
  String shareList = "local:share-list";
}

class _Strings {
  String headerText = "square_header_text".localized();
}
