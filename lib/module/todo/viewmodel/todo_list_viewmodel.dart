import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/extensions/exception_extensions.dart';
import 'package:playflutter/core/model/entity/todo.dart';
import 'package:playflutter/core/tools/callback/page_callback_handler.dart';
import 'package:playflutter/core/tools/log_tools.dart';
import 'package:playflutter/core/tools/paging/paging.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/module/todo/callback/todo_action_callback.dart';
import 'package:playflutter/module/todo/model/entity/todo_type.dart';
import 'package:playflutter/module/todo/model/todo_model.dart';
import 'package:playflutter/core/widget/common/sliding_pane_container.dart';
import 'package:playflutter/core/widget/dialog/loading_dialog.dart';
import 'package:playflutter/module/todo/todo_route_names.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description
class TodoListViewModel extends BaseViewModel implements TodoActionCallback {
  final _model = TodoModel();
  final slidingPaneController = SlidingPaneController();
  late TodoType type;
  late TodoStatus status;
  late Paging<Todo> paging;
  late PageCallbackHandler<TodoActionCallback> callbackHandler;

  TodoListViewModel(
      super.context, this.type, this.status, this.callbackHandler);

  @override
  void init() {
    paging = Paging.build(notifier: this, initPage: 1);
    callbackHandler.addCallback(status.toString(), this);
    if (status == TodoStatus.COMPLETE) requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    paging.dispose();
    slidingPaneController.dispose();
    callbackHandler.removeCallback(status.toString());
  }

  @override
  void onTypeChange(TodoType type) {
    this.type = type;
    paging.statusController.pageLoading();
    requestData(LoadStatus.refresh);
  }

  @override
  void onAdd(Todo todo) {
    final index = paging.data.indexWhere((element) => element.date < todo.date);

    if (index == -1 || paging.data.isEmpty) {
      paging.data.add(todo);
    } else {
      paging.data.insert(index, todo);
    }
    paging.notifyDataChange();
  }

  @override
  void onUpdate(Todo todo) {
    final index = paging.data.indexWhere((element) => todo.id == element.id);
    paging.data.removeAt(index);
    paging.data.insert(index, todo);
    paging.notifyDataChange();
  }

  void requestData(LoadStatus status) async {
    LogTools.log(
        "TodoList", "requestData type:$type,status:${this.status} - $status");

    // request todos list data.
    paging.requestData(
        status,
        (page) => _model
            .postTodoDataAsync(page, type.index, this.status.index)
            .then((value) => value.data));
  }

  void onItemClick(Todo item) {
    Navigator.of(context)
        .pushNamed(TodoRouteNames.create_todo, arguments: item)
        .then((value) {
      // 页面返回值 item点击只可能是update
      if (value is TodoResult) {
        callbackHandler.notifyAt(
            status.toString(), (callback) => callback.onUpdate(value.todo));
      }
    });
  }

  void onItemDelete(Todo item) {
    slidingPaneController.closeAction();
    showDialog(context: context, builder: (context) => const LoadingDialog());

    _model.postDeleteTodoAsync(item.id + 123456).then((value) {
      paging.data.remove(item);
      paging.notifyDataChange();
    }).catchError((onError) {
      onFailedToast(onError);
    }).whenComplete(() {
      Navigator.pop(context);
    });
  }

  void onItemUpdate(Todo item) {
    slidingPaneController.closeAction();
    showDialog(context: context, builder: (context) => const LoadingDialog());

    var targetStatus = status == TodoStatus.COMPLETE
        ? TodoStatus.UPCOMING
        : TodoStatus.COMPLETE;

    _model.postUpdateTodoStatusAsync(item.id, targetStatus.index).then((value) {
      paging.data.remove(item);
      paging.notifyDataChange();
      // 通知另一状态页面添加被更改状态的数据
      callbackHandler.notifyAt(
          targetStatus.toString(), (callback) => callback.onAdd(item));
    }).catchError((onError) {
      onFailedToast(onError);
    }).whenComplete(() {
      Navigator.pop(context);
    });
  }

  /// 是否是第一个分组的key
  isFirstGroupItem(Todo item) {
    final list = paging.data;
    final index = list.indexOf(item);
    if (index == 0) return true;

    final prev = list[index - 1];
    if (item.dateStr != prev.dateStr) return true;
    if (item.dateStr == prev.dateStr) return false;
    return false;
  }
}
