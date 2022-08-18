import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/theme/theme_constants.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/local_tools.dart';
import 'package:playflutter/view/todo/dialog/select_todo_type_dialog.dart';
import 'package:playflutter/view/todo/model/entity/todo_tab.dart';
import 'package:playflutter/view/todo/model/entity/todo_type.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 笔记本模块viewModel
class TodoViewModel extends BaseViewModel {
  final viewStates = _TodoViewState();

  TodoViewModel(super.context);

  @override
  void init() {
    _initTodoType();
  }

  @override
  void onCleared() {}

  showSelectedTodoTypeDialog() {
    showDialog(
        context: context,
        builder: (context) => SelectTodoTypeDialog(
            startIndex: viewStates.type.index,
            onDismiss: () => _updateTodoType(),
            onSelectedItemChanged: (index) {
              viewStates.type = TodoType.values[index];
            }));
  }

  void changeTab(index) {
    viewStates.tabIndex = index;
    viewStates.pageController.jumpToPage(index);
    notifyListeners();
  }

  _initTodoType() async {
    final typeIndex = await LocalTools.get(ThemeConstants.LOCAL_TODO_TYPE,
        defaultValue: TodoType.DEFAULT.index);
    viewStates.type = TodoType.values[typeIndex];
    notifyListeners();
  }

  _updateTodoType() {
    runViewContext((context) {
      LocalTools.save(ThemeConstants.LOCAL_TODO_TYPE, viewStates.type.index);
      notifyListeners();
    });
  }
}

class _TodoViewState {
  var type = TodoType.DEFAULT;
  var tabIndex = 0;
  final todoTabs = TodoTab.getTodoTabs();
  final pageController = PageController(initialPage: 0);

  String typeToTitle() {
    switch (type) {
      case TodoType.WORK:
        return ThemeStrings.todoTypeWork;
      case TodoType.LIFE:
        return ThemeStrings.todoTypeLife;
      case TodoType.PLAY:
        return ThemeStrings.todoTypePlay;
      default:
        return ThemeStrings.todoTypeDefault;
    }
  }
}
