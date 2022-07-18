import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel_state.dart';
import 'package:playflutter/view/me/viewmodel/collect_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 收藏列表页面
class CollectPage extends StatefulWidget {
  const CollectPage({super.key});

  @override
  State<StatefulWidget> createState() => _CollectPageState();
}

class _CollectPageState extends ViewModelState<CollectPage, CollectViewModel> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Collect Page."));
  }
}
