import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/view/system/viewmodel/system_content_viewmodel.dart';
import 'package:playflutter/widget/common/header/app_header_spacer.dart';
import 'package:playflutter/widget/item/parent_tab_item.dart';
import 'package:playflutter/widget/status/super_list_view.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 主页体系tab 体系内容页面
class SystemContentPage extends StatefulWidget {
  const SystemContentPage({super.key});

  @override
  State<StatefulWidget> createState() => _SystemContentState();
}

class _SystemContentState extends BasePageState<SystemContentPage>
    with AutomaticKeepAliveClientMixin<SystemContentPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildViewModel<SystemContentViewModel>(
        create: (context) => SystemContentViewModel(context),
        viewBuild: (context, viewModel) => SuperListView(
            itemCount: viewModel.paging.data.length,
            statusController: viewModel.paging.statusController,
            headerChildren: const [AppHeaderSpacer()],
            itemBuilder: (context, index) {
              var item = viewModel.paging.data[index];
              return ParentTabItem(
                  parentTab: item,
                  onItemClick: (parentTab) => Navigator.of(context).pushNamed(
                      RouteNames.system_content_tab,
                      arguments: parentTab));
            }));
  }
}
