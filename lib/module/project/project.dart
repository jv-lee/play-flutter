import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/tools/localizations.dart';
import 'package:playflutter/module/project/project_list.dart';
import 'package:playflutter/module/project/viewmodel/project_viewmodel.dart';
import 'package:playflutter/core/widget/common/overscroll_hide_container.dart';
import 'package:playflutter/core/widget/status/status_page.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 项目tab列表
class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProjectState();
}

class _ProjectState extends BasePageState<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<ProjectViewModel>(
        create: (context) => ProjectViewModel(context),
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
                    title: Text("home_project_category_name".localized()),
                    bottom: tabBar,
                  ),
                  body: StatusPage(
                      status: viewModel.viewStates.pageStatus,
                      onPageReload: () => viewModel.requestTabData(),
                      child: OverscrollHideContainer(
                          scrollChild: TabBarView(
                              children: tabList
                                  .map((e) => ProjectListPage(id: e.id))
                                  .toList())))));
        });
  }
}
