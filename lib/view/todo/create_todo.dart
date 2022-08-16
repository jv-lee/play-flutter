import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description 创建/编辑 笔记页面
class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends BasePageState<CreateTodoPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("create todo page.")));
  }
}
