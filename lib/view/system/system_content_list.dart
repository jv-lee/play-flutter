import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:playflutter/base/viewmodel_state_create.dart';
import 'package:playflutter/entity/parent_tab.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/system/viewmodel/system_content_list_viewmodel.dart';
import 'package:playflutter/widget/item/content_item.dart';
import 'package:playflutter/widget/status/super_list_view.dart';

/// @author jv.lee
/// @date 2022/7/26
/// @description 体系内容详情页 tab子页面 list数据页
class SystemContentListPage extends StatefulWidget {
  final Children children;

  const SystemContentListPage({Key? key, required this.children})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SystemContentListState();
}

class _SystemContentListState extends ViewModelStateCreate<
        SystemContentListPage, SystemContentListViewModel>
    with AutomaticKeepAliveClientMixin<SystemContentListPage> {

  @override
  bool get wantKeepAlive => true;

  @override
  SystemContentListViewModel createVM() {
    return SystemContentListViewModel(widget.children.id);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
          color: Theme.of(context).primaryColorLight,
          onRefresh: () async {
            await Future<void>.delayed(const Duration(seconds: 1), () {
              findVM().requestData(LoadStatus.refresh);
            });
          },
          child: SuperListView(
            statusController: findVM().paging.statusController,
            itemCount: findVM().paging.data.length,
            onPageReload: () {
              findVM().requestData(LoadStatus.refresh);
            },
            onItemReload: () {
              findVM().requestData(LoadStatus.reload);
            },
            onLoadMore: () {
              findVM().requestData(LoadStatus.loadMore);
            },
            itemBuilder: (BuildContext context, int index) {
              var item = findVM().paging.data[index];
              return ContentItem(
                content: item,
                onItemClick: (item) => {
                  Navigator.pushNamed(context, RouteNames.details,
                      arguments: item.transformDetails())
                },
              );
            },
          )),
    );
  }

}
