import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/extensions/common_extensions.dart';
import 'package:playflutter/model/entity/todo.dart';
import 'package:playflutter/theme/theme_constants.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/local_tools.dart';
import 'package:playflutter/tools/time_tools.dart';
import 'package:playflutter/view/todo/model/entity/todo_type.dart';
import 'package:playflutter/view/todo/model/todo_model.dart';
import 'package:playflutter/widget/dialog/loading_dialog.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description
class CreateTodoViewModel extends BaseViewModel {
  final _model = TodoModel();
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

  changeDate() async {
    final dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2099));
    if (dateTime != null) {
      viewStates.date = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
      notifyListeners();
    }
  }

  onSubmit() {
    FocusManager.instance.primaryFocus?.unfocus();
    // 创建逻辑
    if (viewStates.appbarTitle == ThemeStrings.titleCreate) {
      _createTodo();
    } else {
      _updateTodo();
    }
  }

  _createTodo() {
    showDialog(context: context, builder: (context) => const LoadingDialog());

    _model
        .postAddTodoAsync(viewStates.title, viewStates.content, viewStates.date,
            viewStates.type, viewStates.priority)
        .then((value) {
      // 关闭loading
      Navigator.pop(context);
      // 关闭页面
      Navigator.pop(context, TodoResult(viewStates.isAdd, todo: value.data));
    }).catchError((onError) {
      onFailedToast(onError);
      Navigator.pop(context);
    });
  }

  _updateTodo() {
    showDialog(context: context, builder: (context) => const LoadingDialog());

    _model
        .postUpdateTodoAsync(
            viewStates.id,
            viewStates.title,
            viewStates.content,
            viewStates.date,
            viewStates.type,
            viewStates.priority,
            viewStates.status)
        .then((value) {
      // 关闭loading
      Navigator.pop(context);
      // 关闭页面
      Navigator.pop(context, TodoResult(viewStates.isAdd, todo: value.data));
    }).catchError((onError) {
      onFailedToast(onError);
      Navigator.pop(context);
    });
  }

  _changeTodo(Todo? todo) async {
    if (todo != null) {
      viewStates.isAdd = false;
      viewStates.appbarTitle = ThemeStrings.titleEdit;
      viewStates.id = todo.id;
      viewStates.title = todo.title;
      viewStates.content = todo.content;
      viewStates.priority = todo.priority;
      viewStates.date = todo.dateStr;
      viewStates.status = todo.status;
    } else {
      viewStates.isAdd = true;
      viewStates.appbarTitle = ThemeStrings.titleCreate;
      viewStates.date = TimeTools.getCurrentFormatDate();
    }
    final typeIndex = await LocalTools.get(ThemeConstants.LOCAL_TODO_TYPE,
        defaultValue: TodoType.DEFAULT.index);
    viewStates.type = typeIndex;
    notifyListeners();
  }
}

class _CreateTodoViewState {
  var isAdd = true;
  var appbarTitle = ThemeStrings.titleCreate;
  var type = TodoType.DEFAULT.index;
  var priority = TodoPriority.LOW.index;
  var status = TodoStatus.UPCOMING.index;
  var id = 0;
  var title = "";
  var content = "";
  var date = "";
}
