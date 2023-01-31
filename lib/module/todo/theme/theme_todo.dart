// ignore_for_file: library_private_types_in_public_api

/// @author jv.lee
/// @date 2023/1/31
/// @description
class ThemeTodo {
  static _Constants constants = _Constants();
  static _Dimens dimens = _Dimens();
  static _Images images = _Images();
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
