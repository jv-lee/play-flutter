import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/extensions/data_format_extensions.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/core/widget/item/action_text_item.dart';
import 'package:playflutter/core/widget/status/super_list_view.dart';
import 'package:playflutter/module/details/theme/theme_details.dart';
import 'package:playflutter/module/me/theme/theme_me.dart';
import 'package:playflutter/module/me/viewmodel/collect_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 收藏列表页面
class CollectPage extends StatefulWidget {
  const CollectPage({super.key});

  @override
  State<StatefulWidget> createState() => _CollectPageState();
}

class _CollectPageState extends BasePageState<CollectPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<CollectViewModel>(
        create: (context) => CollectViewModel(context),
        viewBuild: (context, viewModel) => Scaffold(
            appBar: AppBar(title: Text(ThemeMe.strings.meItemCollect)),
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
                      return ActionTextItem(
                          content: item,
                          slidingPaneController:
                              viewModel.slidingPaneController,
                          onItemClick: (item) => Navigator.pushNamed(
                              context, ThemeDetails.routes.details,
                              arguments: item.transformDetails()),
                          onItemDelete: (item) =>
                              viewModel.requestDeleteItem(item));
                    }))));
  }
}
