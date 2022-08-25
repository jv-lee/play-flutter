import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/extensions/exception_extensions.dart';
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
    if (viewStates.titleController.value.isComposingRangeValid) return;
    viewStates.title = title;
    notifyListeners();
  }

  changeContent(String content) {
    if (viewStates.contentController.value.isComposingRangeValid) return;
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
      viewStates
        ..isAdd = false
        ..appbarTitle = ThemeStrings.titleEdit
        ..id = todo.id
        ..title = todo.title
        ..content = todo.content
        ..priority = todo.priority
        ..date = todo.dateStr
        ..status = todo.status
        ..titleController.text = todo.title
        ..contentController.text = todo.content;
    } else {
      viewStates
        ..isAdd = true
        ..appbarTitle = ThemeStrings.titleCreate
        ..date = TimeTools.getCurrentFormatDate();
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
  late TextEditingController titleController;
  late TextEditingController contentController;

  _CreateTodoViewState() {
    titleController = TextEditingController.fromValue(TextEditingValue(
        text: title,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: title.length))));
    contentController = TextEditingController.fromValue(TextEditingValue(
        text: content,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: content.length))));
  }
}
