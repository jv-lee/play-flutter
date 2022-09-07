import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
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

class _OfficialListState extends BasePageState<OfficialListPage>
    with AutomaticKeepAliveClientMixin<OfficialListPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildViewModel<OfficialListViewModel>(
        create: (context) => OfficialListViewModel(context, widget.id),
        viewBuild: (context, viewModel) => Scaffold(
            body: RefreshIndicator(
                color: Theme.of(context).primaryColorLight,
                onRefresh: () async {
                  await Future<void>.delayed(const Duration(seconds: 1),
                      () => viewModel.requestData(LoadStatus.refresh));
                },
                child: SuperListView(
                    statusController: viewModel.paging.statusController,
                    itemCount: viewModel.paging.data.length,
                    onPageReload: () =>
                        viewModel.requestData(LoadStatus.refresh),
                    onItemReload: () =>
                        viewModel.requestData(LoadStatus.reload),
                    onLoadMore: () =>
                        viewModel.requestData(LoadStatus.loadMore),
                    itemBuilder: (BuildContext context, int index) {
                      var item = viewModel.paging.data[index];
                      return ContentItem(
                          content: item,
                          onItemClick: (item) => Navigator.pushNamed(
                              context, RouteNames.details,
                              arguments: item.transformDetails()));
                    }))));
  }
}
