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
  String createShareText = "square_create_share_text".localized();
  String shareTitleText = "square_share_title_text".localized();
  String shareLinkText = "square_share_link_text".localized();
  String shareTitleHint = "square_share_title_hint".localized();
  String shareLinkHint = "square_share_link_hint".localized();
  String shareRequestSuccess = "square_share_request_success".localized();
  String createShareDescription = "square_create_share_description".localized();
}
