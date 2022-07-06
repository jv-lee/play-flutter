import 'package:flutter/material.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/theme/theme_svg_paths.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/square/viewmodel/square_viewmodel.dart';
import 'package:playflutter/widget/common/app_gradient_text_bar.dart';
import 'package:playflutter/widget/common/app_header_container.dart';
import 'package:playflutter/widget/common/app_header_spacer.dart';
import 'package:playflutter/widget/item/content_item.dart';
import 'package:playflutter/widget/status/super_list_view.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页广场tab
class SquarePage extends StatefulWidget {
  const SquarePage({super.key});

  @override
  State<StatefulWidget> createState() => _SquareState();
}

class _SquareState extends State<SquarePage>
    with AutomaticKeepAliveClientMixin<SquarePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<SquareViewModel>().bindView(this);
  }

  @override
  void dispose() {
    context.read<SquareViewModel>().unbindView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var viewModel = context.read<SquareViewModel>();
    return Stack(
      children: [
        RefreshIndicator(
            displacement: 10,
            edgeOffset: AppHeaderSpacer.spacerHeight(),
            color: Theme.of(context).primaryColorLight,
            onRefresh: () async {
              await Future<void>.delayed(const Duration(seconds: 1), () {
                viewModel.requestData(LoadStatus.refresh);
              });
            },
            child: SuperListView(
              statusController:
                  Provider.of<SquareViewModel>(context).paging.statusController,
              itemCount:
                  Provider.of<SquareViewModel>(context).paging.data.length,
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
                var item =
                    Provider.of<SquareViewModel>(context).paging.data[index];
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
            child: AppGradientTextBar(
          title: ThemeStrings.square_header_text,
          navigationSvgPath: ThemeSvgPaths.svg_add,
          onNavigationClick: () {
            Navigator.pushNamed(context, RouteNames.create_share);
          },
        ))
      ],
    );
  }
}
