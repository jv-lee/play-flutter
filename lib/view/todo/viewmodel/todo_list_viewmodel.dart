import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/model/entity/todo.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/todo/callback/todo_action_callback.dart';
import 'package:playflutter/view/todo/model/entity/todo_type.dart';
import 'package:playflutter/view/todo/model/todo_model.dart';
import 'package:playflutter/widget/callback/page_callback_handler.dart';
import 'package:playflutter/widget/common/sliding_pane_container.dart';
import 'package:toast/toast.dart';

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

  void requestData(LoadStatus status) async {
    LogTools.log(
        "TodoList", "requestData type:$type,status:${this.status} - $status");

    // request square list data.
    paging.requestData(
        status,
        (page) => _model
            .postTodoDataAsync(page, type.index, this.status.index)
            .then((value) => value.data));
  }

  void onItemClick(Todo item) {
    Toast.show("click -> item:${item.title}");
  }

  void onItemDelete(Todo item) {
    Toast.show("delete -> item:${item.title}");
    slidingPaneController.closeAction();
  }

  void onItemUpdate(Todo item) {
    Toast.show("update -> item:${item.title}");
    slidingPaneController.closeAction();
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
