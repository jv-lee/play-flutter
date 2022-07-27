import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:playflutter/base/viewmodel_state_create.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/official/viewmodel/official_list_viewmodel.dart';
import 'package:playflutter/widget/item/content_item.dart';
import 'package:playflutter/widget/status/super_list_view.dart';

/// @author jv.lee
/// @date 2022/7/26
/// @description
class OfficialListPage extends StatefulWidget {
  final int id;

  const OfficialListPage({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OfficialListState();
}

class _OfficialListState
    extends ViewModelStateCreate<OfficialListPage, OfficialListViewModel>
    with AutomaticKeepAliveClientMixin<OfficialListPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  OfficialListViewModel createVM() {
    return OfficialListViewModel(widget.id);
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
