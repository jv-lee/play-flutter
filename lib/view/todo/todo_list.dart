import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/view/todo/model/entity/todo_type.dart';
import 'package:playflutter/view/todo/viewmodel/todo_list_viewmodel.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description 笔记本列表页面
class TodoListPage extends StatefulWidget {
  final TodoType type;
  final TodoStatus status;

  const TodoListPage({super.key, required this.type, required this.status});

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
        create: (context) => TodoListViewModel(context),
        viewBuild: (context, viewModel) => Scaffold(
            body: Center(
                child: Text(
                    "type:${widget.type}\nstatus:${widget.status} \ntodo list page."))));
  }
}
