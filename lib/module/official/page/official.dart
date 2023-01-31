import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/widget/common/overscroll_hide_container.dart';
import 'package:playflutter/core/widget/status/status_page.dart';
import 'package:playflutter/module/home/theme/theme_home.dart';
import 'package:playflutter/module/official/page/official_list.dart';
import 'package:playflutter/module/official/viewmodel/official_viewmodel.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 项目tab列表
class OfficialPage extends StatefulWidget {
  const OfficialPage({super.key});

  @override
  State<StatefulWidget> createState() => _OfficialState();
}

class _OfficialState extends BasePageState<OfficialPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<OfficialViewModel>(
        create: (context) => OfficialViewModel(context),
        viewBuild: (context, viewModel) {
          TabBar? tabBar;
          final tabList = viewModel.viewStates.tabList;
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
                    title: Text(ThemeHome.strings.officialCategoryName),
                    bottom: tabBar,
                  ),
                  body: StatusPage(
                      status: viewModel.viewStates.pageStatus,
                      onPageReload: () => viewModel.requestTabData(),
                      child: OverscrollHideContainer(
                          scrollChild: TabBarView(
                              children: tabList
                                  .map((e) => OfficialListPage(id: e.id))
                                  .toList())))));
        });
  }
}
