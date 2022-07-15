import 'package:flutter/material.dart';
import 'package:playflutter/base/vm_state.dart';
import 'package:playflutter/view/square/viewmodel/my_share_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 我的分享页面
class MySharePage extends StatefulWidget {
  const MySharePage({super.key});

  @override
  State<StatefulWidget> createState() => _MySharePageState();
}

class _MySharePageState extends VMState<MySharePage, MyShareViewModel> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("my share page."));
  }
}
