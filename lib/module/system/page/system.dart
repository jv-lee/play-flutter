import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/widget/common/header/app_header_container.dart';
import 'package:playflutter/core/widget/common/overscroll_hide_container.dart';
import 'package:playflutter/core/widget/common/transparent_scaffold.dart';
import 'package:playflutter/module/system/theme/theme_system.dart';
import 'package:playflutter/module/system/viewmodel/system_viewmodel.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 主页体系tab
class SystemPage extends StatefulWidget {
  const SystemPage({super.key});

  @override
  State<StatefulWidget> createState() => _SystemState();
}

class _SystemState extends BasePageState<SystemPage>
    with AutomaticKeepAliveClientMixin<SystemPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildViewModel<SystemViewModel>(
        create: (context) => SystemViewModel(context),
        viewBuild: (context, viewModel) => TransparentScaffold(
            child: Stack(
                children: [buildPage(viewModel), buildTabHeader(viewModel)])));
  }

  Widget buildTabHeader(SystemViewModel viewModel) {
    return AppHeaderContainer(
        child: SizedBox(
            width: double.infinity,
            height: ThemeCommon.dimens.toolbarHeight,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              buildTab(
                  viewModel,
                  ThemeSystem.strings.systemTab,
                  viewModel.viewStates.selectedIndex == 0,
                  () => viewModel.pageChange(0)),
              buildTab(
                  viewModel,
                  ThemeSystem.strings.navigationTab,
                  viewModel.viewStates.selectedIndex == 1,
                  () => viewModel.pageChange(1))
            ])));
  }

  Widget buildTab(SystemViewModel viewModel, String text, bool isSelected,
      Function onClick) {
    Color color = isSelected
        ? Theme.of(context).focusColor
        : Theme.of(context).hoverColor;
    Color textColor = isSelected
        ? Theme.of(context).hoverColor
        : Theme.of(context).focusColor;
    return InkWell(
        onTap: () => onClick(),
        child: Container(
            width: ThemeSystem.dimens.tabWidth,
            height: ThemeSystem.dimens.tabHeight,
            margin: EdgeInsets.only(
                left: ThemeCommon.dimens.offsetMedium,
                right: ThemeCommon.dimens.offsetMedium),
            alignment: Alignment.center,
            decoration: ShapeDecoration(
                color: color,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(ThemeSystem.dimens.tabRadius))),
            child: Text(text,
                style: TextStyle(
                    color: textColor,
                    fontSize: ThemeCommon.dimens.fontSizeMedium))));
  }

  Widget buildPage(SystemViewModel viewModel) {
    return OverscrollHideContainer(
        scrollChild: PageView.builder(
            itemCount: viewModel.viewStates.pageList.length,
            controller: viewModel.viewStates.pageController,
            // physics: const NeverScrollableScrollPhysics(), //静止PageView滑动
            onPageChanged: (page) => {viewModel.tabChange(page)},
            itemBuilder: (BuildContext context, int index) =>
                viewModel.viewStates.pageList[index]));
  }
}
