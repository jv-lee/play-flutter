import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel_state.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/square/viewmodel/square_viewmodel.dart';
import 'package:playflutter/widget/common/header/app_text_action_bar.dart';
import 'package:playflutter/widget/common/header/app_header_container.dart';
import 'package:playflutter/widget/common/header/app_header_spacer.dart';
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

class _SquareState extends ViewModelState<SquarePage, SquareViewModel>
    with AutomaticKeepAliveClientMixin<SquarePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        RefreshIndicator(
            displacement: 10,
            edgeOffset: AppHeaderSpacer.spacerHeight(),
            color: Theme.of(context).primaryColorLight,
            onRefresh: () async {
              await Future<void>.delayed(const Duration(seconds: 1), () {
                readVM().requestData(LoadStatus.refresh);
              });
            },
            child: SuperListView(
              statusController:
                  providerOfVM().paging.statusController,
              itemCount:
                  providerOfVM().paging.data.length,
              onPageReload: () {
                readVM().requestData(LoadStatus.refresh);
              },
              onItemReload: () {
                readVM().requestData(LoadStatus.reload);
              },
              onLoadMore: () {
                readVM().requestData(LoadStatus.loadMore);
              },
              headerChildren: const [AppHeaderSpacer()],
              itemBuilder: (BuildContext context, int index) {
                var item =
                    providerOfVM().paging.data[index];
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
          onNavigationClick: () {
            Navigator.pushNamed(context, RouteNames.create_share);
          },
        ))
      ],
    );
  }
}
