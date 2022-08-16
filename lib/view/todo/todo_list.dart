import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description 笔记本列表页面
class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<StatefulWidget> createState() => _TodoListPageState();
}

class _TodoListPageState extends BasePageState<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("todo list page.")));
  }
}
