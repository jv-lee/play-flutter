import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/tools/cache/preferences.dart';
import 'package:playflutter/core/tools/callback/page_callback_handler.dart';
import 'package:playflutter/module/todo/callback/todo_action_callback.dart';
import 'package:playflutter/module/todo/dialog/select_todo_type_dialog.dart';
import 'package:playflutter/module/todo/model/entity/todo_tab.dart';
import 'package:playflutter/module/todo/model/entity/todo_type.dart';
import 'package:playflutter/module/todo/theme/theme_todo.dart';

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
  void onCleared() {
    viewStates.pageController.dispose();
    viewStates.callbackHandler.dispose();
  }

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

  void navigationCreateTodo() {
    Navigator.of(context).pushNamed(ThemeTodo.routes.createTodo).then((value) {
      // 页面返回值
      if (value is TodoResult) {
        // 页面新增通知刷新
        viewStates.callbackHandler.notifyAt(TodoStatus.UPCOMING.toString(),
            (callback) => callback.onAdd(value.todo));
      }
    });
  }

  _initTodoType() async {
    final typeIndex = await Preferences.get(ThemeTodo.constants.todoType,
        defaultValue: TodoType.DEFAULT.index);
    viewStates.type = TodoType.values[typeIndex];
    viewStates.callbackHandler.notifyAll((callback) {
      callback.onTypeChange(viewStates.type);
    });
    notifyListeners();
  }

  _updateTodoType() {
    runViewContext((context) async {
      var localType = await Preferences.get(ThemeTodo.constants.todoType,
          defaultValue: TodoType.DEFAULT.index);
      if (localType == viewStates.type.index) return; // 相同类型忽略
      Preferences.save(ThemeTodo.constants.todoType, viewStates.type.index);
      viewStates.callbackHandler.notifyAll((callback) {
        callback.onTypeChange(viewStates.type);
      });
      notifyListeners();
    });
  }
}

class _TodoViewState {
  var type = TodoType.DEFAULT;
  var tabIndex = 0;
  final todoTabs = TodoTab.getTodoTabs();
  final pageController = PageController(initialPage: 0);
  final callbackHandler = PageCallbackHandler<TodoActionCallback>();

  String typeToTitle() {
    switch (type) {
      case TodoType.WORK:
        return ThemeTodo.strings.typeWork;
      case TodoType.LIFE:
        return ThemeTodo.strings.typeLife;
      case TodoType.PLAY:
        return ThemeTodo.strings.typePlay;
      default:
        return ThemeTodo.strings.typeDefault;
    }
  }
}
