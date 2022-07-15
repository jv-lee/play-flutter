import 'package:flutter/material.dart';
import 'package:playflutter/base/vm_state.dart';
import 'package:playflutter/view/todo/viewmodel/todo_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description Todo模块主页面
class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<StatefulWidget> createState() => _TodoPageState();
}

class _TodoPageState extends VMState<TodoPage, TodoViewModel> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("todo page."));
  }
}
