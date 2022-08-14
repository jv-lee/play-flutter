import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description Todo模块主页面
class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<StatefulWidget> createState() => _TodoPageState();
}

class _TodoPageState extends BasePageState<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("todo page.")));
  }
}
