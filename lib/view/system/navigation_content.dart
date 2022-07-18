import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel_state.dart';
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

/// @author jv.lee
/// @date 2022/6/30
/// @description 主页体系tab 导航内容页面
class NavigationContentPage extends StatefulWidget {
  const NavigationContentPage({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationContentState();
}

class _NavigationContentState
    extends ViewModelState<NavigationContentPage, NavigationContentViewModel>
    with AutomaticKeepAliveClientMixin<NavigationContentPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      child: StatusPage(
        status: providerOfVM().paging.statusController.pageStatus,
        child: Padding(
          padding: EdgeInsets.only(top: AppHeaderSpacer.spacerHeight()),
          child: Row(
            children: [
              Expanded(flex: 1, child: buildTabList()),
              Expanded(flex: 2, child: buildTagList())
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabList() {
    return OverscrollHideContainer(
        scrollChild: ListView.builder(
            controller: providerOfVM().tabScrollController,
            padding: EdgeInsets.zero,
            itemCount: providerOfVM().paging.data.length,
            itemBuilder: (context, index) {
              var item = providerOfVM().paging.data[index];
              return NavigationTabItem(
                navigationTab: item,
                isSelected: providerOfVM().tabSelectedIndex == index,
                onItemClick: (content) => {readVM().changeTabIndex(index)},
              );
            }));
  }

  Widget buildTagList() {
    return OverscrollHideContainer(
        scrollChild: ScrollToIndexList(
      topDistance: -StatusTools.getStatusHeight(),
      controller: providerOfVM().tagScrollController,
      list: providerOfVM().paging.data,
      itemBuilder: (context, index) {
        var item = providerOfVM().paging.data[index];
        return NavigationTagItem(
          key: item.globalKey,
          navigationTab: item,
          onItemClick: (content) => {
            Navigator.pushNamed(context, RouteNames.details,
                arguments: content.transformDetails())
          },
        );
      },
      callback: (first, last) => {readVM().changeTagIndex(first)},
    ));
  }
}
