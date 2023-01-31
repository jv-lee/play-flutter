import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/extensions/exception_extensions.dart';
import 'package:playflutter/core/model/entity/todo.dart';
import 'package:playflutter/core/tools/cache/preferences.dart';
import 'package:playflutter/core/tools/localizations.dart';
import 'package:playflutter/core/tools/time_tools.dart';
import 'package:playflutter/core/widget/dialog/loading_dialog.dart';
import 'package:playflutter/module/todo/model/entity/todo_type.dart';
import 'package:playflutter/module/todo/model/todo_model.dart';
import 'package:playflutter/module/todo/theme/theme_todo.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description 创建/编辑 笔记页面数据 viewModel
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
    // 校验iOS拼音输入时未确定之前过滤拼音字母的无效占位输入
    if (viewStates.titleController.value.isComposingRangeValid) return;
    viewStates.title = title;
    notifyListeners();
  }

  changeContent(String content) {
    // 校验iOS拼音输入时未确定之前过滤拼音字母的无效占位输入
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
    if (viewStates.appbarTitle == "title_create".localized()) {
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
        ..appbarTitle = "title_edit".localized()
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
        ..appbarTitle = "title_create".localized()
        ..date = TimeTools.getCurrentFormatDate();
    }
    final typeIndex = await Preferences.get(ThemeTodo.constants.todoType,
        defaultValue: TodoType.DEFAULT.index);
    viewStates.type = typeIndex;
    notifyListeners();
  }
}

class _CreateTodoViewState {
  var isAdd = true;
  var appbarTitle = "title_create".localized();
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
