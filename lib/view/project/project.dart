import 'package:flutter/material.dart';
import 'package:playflutter/base/page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/project/project_list.dart';
import 'package:playflutter/view/project/viewmodel/project_viewmodel.dart';
import 'package:playflutter/widget/status/status_page.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 项目tab列表
class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProjectState();
}

class _ProjectState extends PageState<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<ProjectViewModel>(
        create: (context) => ProjectViewModel(context),
        viewBuild: (context, viewModel) {
          TabBar? tabBar;
          final tabList = viewModel.tabList;
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
                  title: const Text(ThemeStrings.project_category_name),
                  bottom: tabBar,
                ),
                body: StatusPage(
                    status: viewModel.pageStatus,
                    reLoadFun: () => viewModel.requestTabData(),
                    child: TabBarView(
                        children: tabList
                            .map((e) => ProjectListPage(id: e.id))
                            .toList())),
              ));
        });
  }
}
