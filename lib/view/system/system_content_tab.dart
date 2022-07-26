import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/base/viewmodel_state.dart';
import 'package:playflutter/entity/parent_tab.dart';
import 'package:playflutter/view/system/viewmodel/system_content_tab_viewmodel.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/7/26
/// @description 体系内容详情Tab页面
class SystemContentTabPage extends StatefulWidget {
  final List<Children> tabs;

  const SystemContentTabPage({Key? key, required this.tabs}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SystemContentTabState();
}

class _SystemContentTabState
    extends ViewModelState<SystemContentTabPage, SystemContentTabViewModel> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
