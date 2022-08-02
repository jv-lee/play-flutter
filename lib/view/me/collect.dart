import 'package:flutter/material.dart';
import 'package:playflutter/base/page_state.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 收藏列表页面
class CollectPage extends StatefulWidget {
  const CollectPage({super.key});

  @override
  State<StatefulWidget> createState() => _CollectPageState();
}

class _CollectPageState extends PageState<CollectPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Collect Page.")),
    );
  }
}
