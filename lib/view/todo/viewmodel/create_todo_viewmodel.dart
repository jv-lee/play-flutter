import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/model/entity/todo.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/time_tools.dart';
import 'package:playflutter/view/todo/model/entity/todo_type.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description
class CreateTodoViewModel extends BaseViewModel {
  final viewStates = _CreateTodoViewState();

  CreateTodoViewModel(super.context);

  @override
  void init() {
    runViewContext((context) {
      final todo = (ModalRoute.of(context)?.settings.arguments as Todo?);
      _changeTodo(todo);
    });
  }

  @override
  void onCleared() {}

  changeTitle(String title) {
    viewStates.title = title;
    notifyListeners();
  }

  changeContent(String content) {
    viewStates.content = content;
    notifyListeners();
  }

  changePriority(int priority) {
    viewStates.priority = priority;
    notifyListeners();
  }

  changeDate() {}

  onSubmit() {}

  _changeTodo(Todo? todo) {
    if (todo != null) {
      viewStates.appbarTitle = ThemeStrings.titleEdit;
      viewStates.title = todo.title;
      viewStates.content = todo.content;
      viewStates.priority = todo.priority;
      viewStates.date = todo.dateStr;
    } else {
      viewStates.appbarTitle = ThemeStrings.titleCreate;
      viewStates.date = TimeTools.getCurrentFormatDate();
    }
    notifyListeners();
  }
}

class _CreateTodoViewState {
  var appbarTitle = ThemeStrings.titleCreate;
  var title = "";
  var content = "";
  var priority = TodoPriority.LOW.index;
  var date = "";
}
