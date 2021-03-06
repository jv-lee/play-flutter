import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel_state.dart';
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

class _SystemContentState extends ViewModelState<SystemContentPage,SystemContentViewModel>
    with AutomaticKeepAliveClientMixin<SystemContentPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SuperListView(
      itemCount: providerOfVM().paging.data.length,
      statusController: providerOfVM().paging.statusController,
      headerChildren: const [AppHeaderSpacer()],
      itemBuilder: (context, index) {
        var item = providerOfVM().paging.data[index];
        return ParentTabItem(
          parentTab: item,
          onItemClick: (parentTab) => {},
        );
      },
    );
  }
}
