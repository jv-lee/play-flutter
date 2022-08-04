import 'package:flutter/material.dart';
import 'package:playflutter/base/page_state.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/square/viewmodel/square_viewmodel.dart';
import 'package:playflutter/widget/common/header/app_header_container.dart';
import 'package:playflutter/widget/common/header/app_header_spacer.dart';
import 'package:playflutter/widget/common/header/app_text_action_bar.dart';
import 'package:playflutter/widget/item/content_item.dart';
import 'package:playflutter/widget/status/super_list_view.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页广场tab
class SquarePage extends StatefulWidget {
  const SquarePage({super.key});

  @override
  State<StatefulWidget> createState() => _SquareState();
}

class _SquareState extends PageState<SquarePage>
    with AutomaticKeepAliveClientMixin<SquarePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return createViewModel<SquareViewModel>(
        (context) => SquareViewModel(context),
        (context, viewModel) => Stack(
              children: [
                RefreshIndicator(
                    displacement: 10,
                    edgeOffset: AppHeaderSpacer.spacerHeight(),
                    color: Theme.of(context).primaryColorLight,
                    onRefresh: () async {
                      await Future<void>.delayed(const Duration(seconds: 1),
                          () {
                        viewModel.requestData(LoadStatus.refresh);
                      });
                    },
                    child: SuperListView(
                      statusController: viewModel.paging.statusController,
                      itemCount: viewModel.paging.data.length,
                      onPageReload: () {
                        viewModel.requestData(LoadStatus.refresh);
                      },
                      onItemReload: () {
                        viewModel.requestData(LoadStatus.reload);
                      },
                      onLoadMore: () {
                        viewModel.requestData(LoadStatus.loadMore);
                      },
                      headerChildren: const [AppHeaderSpacer()],
                      itemBuilder: (BuildContext context, int index) {
                        var item = viewModel.paging.data[index];
                        return ContentItem(
                          content: item,
                          onItemClick: (item) => {
                            Navigator.pushNamed(context, RouteNames.details,
                                arguments: item.transformDetails())
                          },
                        );
                      },
                    )),
                AppHeaderContainer(
                    child: AppTextActionBar(
                  title: ThemeStrings.square_header_text,
                  navigationSvgPath: ThemeImages.common_add_svg,
                  onNavigationClick: () => viewModel.navigationCreateShared(),
                ))
              ],
            ));
  }
}
