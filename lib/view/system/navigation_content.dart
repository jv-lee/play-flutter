/// @author jv.lee
/// @date 2022/6/30
/// @description
import 'package:flutter/material.dart';
import 'package:playflutter/view/system/viewmodel/navigation_content_viewmodel.dart';
import 'package:playflutter/widget/item/navigation_tab_item.dart';
import 'package:playflutter/widget/status/super_list_view.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页体系tab 导航内容页面
class NavigationContentPage extends StatefulWidget {
  const NavigationContentPage({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationContentState();
}

class _NavigationContentState extends State<NavigationContentPage>
    with AutomaticKeepAliveClientMixin<NavigationContentPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<NavigationContentViewModel>().bindView(this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var viewModel = Provider.of<NavigationContentViewModel>(context);
    return SuperListView(
      itemCount: viewModel.paging.data.length,
      statusController: viewModel.paging.statusController,
      itemBuilder: (context, index) {
        var item = viewModel.paging.data[index];
        return NavigationTabItem(
          navigationTab: item,
        );
      },
    );
  }
}
