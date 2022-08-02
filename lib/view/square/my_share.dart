import 'package:flutter/material.dart';
import 'package:playflutter/base/page_state.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 我的分享页面
class MySharePage extends StatefulWidget {
  const MySharePage({super.key});

  @override
  State<StatefulWidget> createState() => _MySharePageState();
}

class _MySharePageState extends PageState<MySharePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("my share page."));
  }
}
