import 'package:flutter/widgets.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/base/viewmodel_state.dart';

/// @author jv.lee
/// @date 2022/7/26
/// @description 体系内容详情页 tab子页面 list数据页
class SystemContentListPage extends StatefulWidget {
  const SystemContentListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SystemContentListState();
}

class _SystemContentListState
    extends ViewModelState<SystemContentListPage, ViewModel> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
