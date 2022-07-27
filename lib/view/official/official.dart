import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel_state.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/official/official_list.dart';
import 'package:playflutter/view/official/viewmodel/official_viewmodel.dart';
import 'package:playflutter/widget/status/status_page.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 项目tab列表
class OfficialPage extends StatefulWidget {
  const OfficialPage({super.key});

  @override
  State<StatefulWidget> createState() => _OfficialState();
}

class _OfficialState extends ViewModelState<OfficialPage, OfficialViewModel> {
  @override
  Widget build(BuildContext context) {
    TabBar? tabBar;
    final tabList = providerOfVM().tabList;
    if (tabList.isNotEmpty) {
      tabBar = TabBar(
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Theme.of(context).primaryColorLight,
          indicatorColor: Theme.of(context).primaryColorLight,
          tabs: tabList.map((e) => Tab(text: e.name)).toList());
    }
    return DefaultTabController(
        length: tabList.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(ThemeStrings.official_category_name),
            bottom: tabBar,
          ),
          body: StatusPage(
              status: readVM().pageStatus,
              reLoadFun: () => readVM().requestTabData(),
              child: TabBarView(
                  children:
                      tabList.map((e) => OfficialListPage(id: e.id)).toList())),
        ));
  }
}