import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/model/entity/todo.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/tools/callback/page_callback_handler.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/core/widget/common/sliding_pane_container.dart';
import 'package:playflutter/core/widget/status/super_list_view.dart';
import 'package:playflutter/module/todo/callback/todo_action_callback.dart';
import 'package:playflutter/module/todo/model/entity/todo_type.dart';
import 'package:playflutter/module/todo/theme/theme_todo.dart';
import 'package:playflutter/module/todo/viewmodel/todo_list_viewmodel.dart';
import 'package:playflutter/module/todo/widget/item/todo_item.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description 笔记本列表页面
class TodoListPage extends StatefulWidget {
  final TodoType type;
  final TodoStatus status;
  final PageCallbackHandler<TodoActionCallback> callbackHandler;

  const TodoListPage(
      {super.key,
      required this.type,
      required this.status,
      required this.callbackHandler});

  @override
  State<StatefulWidget> createState() => _TodoListPageState();
}

class _TodoListPageState extends BasePageState<TodoListPage>
    with AutomaticKeepAliveClientMixin<TodoListPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildViewModel<TodoListViewModel>(
        create: (context) => TodoListViewModel(
            context, widget.type, widget.status, widget.callbackHandler),
        viewBuild: (context, viewModel) => Scaffold(
            body: RefreshIndicator(
                color: Theme.of(context).primaryColorLight,
                onRefresh: () async {
                  await Future<void>.delayed(const Duration(seconds: 1),
                      () => viewModel.requestData(LoadStatus.refresh));
                },
                child: SuperListView(
                    scrollController: viewModel.paging.scrollController,
                    statusController: viewModel.paging.statusController,
                    itemCount: viewModel.paging.data.length,
                    onPageReload: () =>
                        viewModel.requestData(LoadStatus.refresh),
                    onItemReload: () =>
                        viewModel.requestData(LoadStatus.reload),
                    onLoadMore: () =>
                        viewModel.requestData(LoadStatus.loadMore),
                    itemBuilder: (BuildContext context, int index) {
                      var item = viewModel.paging.data[index];
                      final itemWidget = buildTodoItem(viewModel, item);
                      if (viewModel.isFirstGroupItem(item)) {
                        return buildTodoStickyItem(viewModel, item, itemWidget);
                      } else {
                        return itemWidget;
                      }
                    }))));
  }

  Widget buildTodoStickyItem(
      TodoListViewModel viewModel, Todo item, Widget child) {
    return Column(
      children: [
        slidingPaneState(
            viewModel.slidingPaneController,
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: ThemeTodo.dimens.stickyHeaderHeight,
              padding: EdgeInsets.only(left: ThemeCommon.dimens.offsetLarge),
              color: Theme.of(context).hoverColor,
              child: Text(item.dateStr,
                  style: TextStyle(
                      fontSize: ThemeCommon.dimens.fontSizeSmall,
                      color: Theme.of(context).focusColor,
                      fontWeight: FontWeight.bold)),
            )),
        child
      ],
    );
  }

  Widget buildTodoItem(TodoListViewModel viewModel, Todo item) {
    return TodoItem(
      item: item,
      controller: viewModel.slidingPaneController,
      onItemClick: (item) => viewModel.onItemClick(item),
      onItemDelete: (item) => viewModel.onItemDelete(item),
      onItemUpdate: (item) => viewModel.onItemUpdate(item),
    );
  }
}
