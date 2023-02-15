// ignore_for_file: library_private_types_in_public_api

import 'package:playflutter/core/tools/localizations.dart';

/// @author jv.lee
/// @date 2023/1/31
/// @description 笔记模块 资源引用类
class ThemeTodo {
  static _Constants constants = _Constants();
  static _Dimens dimens = _Dimens();
  static _Images images = _Images();
  static _Strings strings = _Strings();
  static _Routes routes = _Routes();
}

class _Constants {
  String todoType = "local:todo-type";
}

class _Dimens {
  double stickyHeaderHeight = 26;
  double slidingWidth = 160;
  double itemHeight = 58;
  double saveButton = 36;
  double editHeight = 56;
  double editContentHeight = 138;
}

class _Images {
  String completeSvg = "assets/images/todo/ic_todo_complete.svg";
  String completeFillSvg = "assets/images/todo/ic_todo_complete_fill.svg";
  String upcomingSvg = "assets/images/todo/ic_todo_upcoming.svg";
  String upcomingFillSvg = "assets/images/todo/ic_todo_upcoming_fill.svg";
  String createSvg = "assets/images/todo/ic_todo_create.svg";
  String replaceSvg = "assets/images/todo/ic_todo_replace.svg";
}

class _Strings {
  String typeDefault = "todo_type_default".localized();
  String typeWork = "todo_type_work".localized();
  String typeLife = "todo_type_life".localized();
  String typePlay = "todo_type_play".localized();
  String createTitleLabel = "todo_create_title_label".localized();
  String createTitleHint = "todo_create_title_hint".localized();
  String createContentLabel = "todo_create_content_label".localized();
  String createContentHint = "todo_create_content_hint".localized();
  String createLevelLabel = "todo_create_level_label".localized();
  String createLevelLow = "todo_create_level_low".localized();
  String createLevelHigh = "todo_create_level_high".localized();
  String createDateLabel = "todo_create_date_label".localized();
  String createSave = "todo_create_save".localized();
  String createSuccess = "todo_create_success".localized();
  String deleteSuccess = "todo_delete_success".localized();
  String updateSuccess = "todo_update_success".localized();
  String moveSuccess = "todo_move_success".localized();
  String itemComplete = "todo_item_complete".localized();
  String itemUpcoming = "todo_item_upcoming".localized();
  String itemLevelHeight = "todo_item_level_height".localized();
}

class _Routes {
  String todo = "/todo";
  String createTodo = "/create_todo";
}