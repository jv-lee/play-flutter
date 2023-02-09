import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/extensions/data_format_extensions.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/core/widget/common/header/app_header_container.dart';
import 'package:playflutter/core/widget/common/header/app_header_spacer.dart';
import 'package:playflutter/core/widget/common/header/app_text_action_bar.dart';
import 'package:playflutter/core/widget/common/transparent_scaffold.dart';
import 'package:playflutter/core/widget/item/content_item.dart';
import 'package:playflutter/core/widget/status/super_list_view.dart';
import 'package:playflutter/module/details/theme/theme_details.dart';
import 'package:playflutter/module/square/theme/theme_square.dart';
import 'package:playflutter/module/square/viewmodel/square_viewmodel.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页广场tab
class SquarePage extends StatefulWidget {
  const SquarePage({super.key});

  @override
  State<StatefulWidget> createState() => _SquareState();
}

class _SquareState extends BasePageState<SquarePage>
    with AutomaticKeepAliveClientMixin<SquarePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildViewModel<SquareViewModel>(
        create: (context) => SquareViewModel(context),
        viewBuild: (context, viewModel) => TransparentScaffold(
                child: Stack(children: [
              RefreshIndicator(
                  displacement: 10,
                  edgeOffset: AppHeaderSpacer.spacerHeight(),
                  color: Theme.of(context).primaryColorLight,
                  onRefresh: () async {
                    await Future<void>.delayed(const Duration(seconds: 1),
                        () => viewModel.requestData(LoadStatus.refresh));
                  },
                  child: SuperListView(
                      scrollController: viewModel.paging.scrollController,
                      statusController: viewModel.paging.statusController,
                      itemCount: viewModel.paging.data.length,
                      onPageReload: () =>
                          viewModel.requestData(LoadStatus.refresh),
                      onItemReload: () =>
                          viewModel.requestData(LoadStatus.reload),
                      onLoadMore: () =>
                          viewModel.requestData(LoadStatus.loadMore),
                      headerChildren: const [AppHeaderSpacer()],
                      itemBuilder: (BuildContext context, int index) {
                        var item = viewModel.paging.data[index];
                        return ContentItem(
                            content: item,
                            onItemClick: (item) => Navigator.pushNamed(
                                context, ThemeDetails.routes.details,
                                arguments: item.transformDetails()));
                      })),
              AppHeaderContainer(
                  child: AppTextActionBar(
                      title: ThemeSquare.strings.headerText,
                      navigationSvgPath: ThemeCommon.images.addSvg,
                      onNavigationClick: () =>
                          viewModel.navigationCreateShared()))
            ])));
  }
}
