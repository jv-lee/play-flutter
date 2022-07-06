/// @author jv.lee
/// @date 2022/6/30
/// @description
import 'package:flutter/material.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/tools/status_tools.dart';
import 'package:playflutter/view/system/viewmodel/navigation_content_viewmodel.dart';
import 'package:playflutter/widget/common/app_header_spacer.dart';
import 'package:playflutter/widget/common/overscroll_hide_container.dart';
import 'package:playflutter/widget/item/navigation_tab_item.dart';
import 'package:playflutter/widget/item/navigation_tag_item.dart';
import 'package:playflutter/widget/scroll/scroll_to_index.dart';
import 'package:playflutter/widget/status/status_page.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页体系tab 导航内容页面
class NavigationContentPage extends StatefulWidget {
  const NavigationContentPage({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationContentState();
}

class _NavigationContentState extends State<NavigationContentPage>
    with AutomaticKeepAliveClientMixin<NavigationContentPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<NavigationContentViewModel>().bindView(this);
  }

  @override
  void dispose() {
    context.read<NavigationContentViewModel>().unbindView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var viewModel = Provider.of<NavigationContentViewModel>(context);
    return Material(
      child: StatusPage(
        status: viewModel.paging.statusController.pageStatus,
        child: Padding(
          padding: EdgeInsets.only(top: AppHeaderSpacer.spacerHeight()),
          child: Row(
            children: [
              Expanded(flex: 1, child: buildTabList(viewModel)),
              Expanded(flex: 2, child: buildTagList(viewModel))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabList(NavigationContentViewModel viewModel) {
    return OverscrollHideContainer(
        scrollChild: ListView.builder(
            controller: viewModel.tabScrollController,
            padding: EdgeInsets.zero,
            itemCount: viewModel.paging.data.length,
            itemBuilder: (context, index) {
              var item = viewModel.paging.data[index];
              return NavigationTabItem(
                navigationTab: item,
                isSelected: viewModel.tabSelectedIndex == index,
                onItemClick: (content) => {viewModel.changeTabIndex(index)},
              );
            }));
  }

  Widget buildTagList(NavigationContentViewModel viewModel) {
    return OverscrollHideContainer(
        scrollChild: ScrollToIndex(
      topDistance: -StatusTools.getStatusHeight(),
      controller: viewModel.tagScrollController,
      list: viewModel.paging.data,
      itemBuilder: (context, index) {
        var item = viewModel.paging.data[index];
        return NavigationTagItem(
          key: item.globalKey,
          navigationTab: item,
          onItemClick: (content) => {
            Navigator.pushNamed(context, RouteNames.details,
                arguments: content.transformDetails())
          },
        );
      },
      callback: (first, last) => {viewModel.changeTagIndex(first)},
    ));
  }
}
