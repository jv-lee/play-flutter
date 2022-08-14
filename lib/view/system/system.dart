import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/system/viewmodel/system_viewmodel.dart';
import 'package:playflutter/widget/common/header/app_header_container.dart';
import 'package:playflutter/widget/common/overscroll_hide_container.dart';
import 'package:playflutter/widget/common/transparent_scaffold.dart';

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
            height: ThemeDimens.toolbarHeight,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              buildTab(
                  viewModel,
                  ThemeStrings.systemSystemTab,
                  viewModel.viewStates.selectedIndex == 0,
                  () => viewModel.pageChange(0)),
              buildTab(
                  viewModel,
                  ThemeStrings.systemNavigationTab,
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
    return Padding(
        padding: const EdgeInsets.only(
            left: ThemeDimens.offsetMedium, right: ThemeDimens.offsetMedium),
        child: InkWell(
            onTap: () => onClick(),
            child: Container(
                width: ThemeDimens.systemTabWidth,
                height: ThemeDimens.systemTabHeight,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                    color: color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            ThemeDimens.systemTabRadius))),
                child: Text(text,
                    style: TextStyle(
                        color: textColor,
                        fontSize: ThemeDimens.fontSizeMedium)))));
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
