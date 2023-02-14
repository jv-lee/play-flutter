import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/widget/common/header/app_header_spacer.dart';
import 'package:playflutter/core/widget/status/super_list_view.dart';
import 'package:playflutter/module/system/theme/theme_system.dart';
import 'package:playflutter/module/system/viewmodel/system_content_viewmodel.dart';
import 'package:playflutter/module/system/widget/item/parent_tab_item.dart';

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
            onPageReload: viewModel.requestData,
            itemBuilder: (context, index) {
              var item = viewModel.paging.data[index];
              return ParentTabItem(
                  parentTab: item,
                  onItemClick: (parentTab) => Navigator.of(context).pushNamed(
                      ThemeSystem.routes.systemContentTab,
                      arguments: parentTab));
            }));
  }
}
