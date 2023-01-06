import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/extensions/data_format_extensions.dart';
import 'package:playflutter/core/tools/status_tools.dart';
import 'package:playflutter/core/widget/common/header/app_header_spacer.dart';
import 'package:playflutter/core/widget/common/overscroll_hide_container.dart';
import 'package:playflutter/core/widget/scroll/scroll_to_index.dart';
import 'package:playflutter/core/widget/status/status_page.dart';
import 'package:playflutter/module/details/details_route_names.dart';
import 'package:playflutter/module/system/viewmodel/navigation_content_viewmodel.dart';
import 'package:playflutter/module/system/widget/item/navigation_tab_item.dart';
import 'package:playflutter/module/system/widget/item/navigation_tag_item.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 主页体系tab 导航内容页面
class NavigationContentPage extends StatefulWidget {
  const NavigationContentPage({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationContentState();
}

class _NavigationContentState extends BasePageState<NavigationContentPage>
    with AutomaticKeepAliveClientMixin<NavigationContentPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildViewModel<NavigationContentViewModel>(
        create: (context) => NavigationContentViewModel(context),
        viewBuild: (context, viewModel) => Material(
            child: StatusPage(
                status: viewModel.paging.statusController.pageStatus,
                onPageReload: viewModel.requestData,
                child: Container(
                    padding:
                        EdgeInsets.only(top: AppHeaderSpacer.spacerHeight()),
                    child: Row(children: [
                      Expanded(flex: 1, child: buildTabList(viewModel)),
                      Expanded(flex: 2, child: buildTagList(viewModel))
                    ])))));
  }

  Widget buildTabList(NavigationContentViewModel viewModel) {
    return OverscrollHideContainer(
        scrollChild: ListView.builder(
            controller: viewModel.viewStates.tabScrollController,
            padding: EdgeInsets.zero,
            itemCount: viewModel.paging.data.length,
            itemBuilder: (context, index) {
              var item = viewModel.paging.data[index];
              return NavigationTabItem(
                  navigationTab: item,
                  isSelected: viewModel.viewStates.tabSelectedIndex == index,
                  onItemClick: (content) => viewModel.changeTabIndex(index));
            }));
  }

  Widget buildTagList(NavigationContentViewModel viewModel) {
    return OverscrollHideContainer(
        scrollChild: ScrollToIndexList(
            topDistance: -StatusTools.getStatusHeight(),
            controller: viewModel.viewStates.tagScrollController,
            list: viewModel.paging.data,
            itemBuilder: (context, index) {
              var item = viewModel.paging.data[index];
              return NavigationTagItem(
                  key: item.globalKey,
                  navigationTab: item,
                  onItemClick: (content) => Navigator.pushNamed(
                      context, DetailsRouteNames.details,
                      arguments: content.transformDetails()));
            },
            callback: (first, last) => viewModel.changeTagIndex(first)));
  }
}
