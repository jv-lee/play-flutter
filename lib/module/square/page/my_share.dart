import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/extensions/data_format_extensions.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/core/widget/item/action_text_item.dart';
import 'package:playflutter/core/widget/status/super_list_view.dart';
import 'package:playflutter/module/details/theme/theme_details.dart';
import 'package:playflutter/module/me/theme/theme_me.dart';
import 'package:playflutter/module/square/viewmodel/my_share_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 我的分享页面
class MySharePage extends StatefulWidget {
  const MySharePage({super.key});

  @override
  State<StatefulWidget> createState() => _MySharePageState();
}

class _MySharePageState extends BasePageState<MySharePage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<MyShareViewModel>(
        create: (context) => MyShareViewModel(context),
        viewBuild: (context, viewModel) => Scaffold(
            appBar: AppBar(title: Text(ThemeMe.strings.meItemShare)),
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
