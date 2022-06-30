import 'package:flutter/material.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/system/viewmodel/system_viewmodel.dart';
import 'package:playflutter/widget/common/app_header_container.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页体系tab
class SystemPage extends StatefulWidget {
  const SystemPage({super.key});

  @override
  State<StatefulWidget> createState() => _SystemState();
}

class _SystemState extends State<SystemPage>
    with AutomaticKeepAliveClientMixin<SystemPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<SystemViewModel>().bindView(this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var viewModel = Provider.of<SystemViewModel>(context);
    return Column(children: [buildTabHeader(viewModel), buildPage(viewModel)]);
  }

  Widget buildTabHeader(SystemViewModel viewModel) {
    return AppHeaderContainer(
        child: SizedBox(
      width: double.infinity,
      height: ThemeDimens.toolbar_height,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        buildTab(ThemeStrings.system_system_tab,
            viewModel.selectedIndex == 0, () => {viewModel.tabChange(0)}),
        buildTab(ThemeStrings.system_navigation_tab,
            viewModel.selectedIndex == 1, () => {viewModel.tabChange(1)})
      ]),
    ));
  }

  Widget buildTab(String text, bool isSelected, Function onClick) {
    Color color;
    Color textColor;
    if (isSelected) {
      color = Theme.of(context).focusColor;
      textColor = Theme.of(context).hoverColor;
    } else {
      color = Theme.of(context).hoverColor;
      textColor = Theme.of(context).focusColor;
    }
    return Padding(
      padding: const EdgeInsets.only(
          left: ThemeDimens.offset_medium, right: ThemeDimens.offset_medium),
      child: InkWell(
        onTap: () => {onClick()},
        child: Container(
            width: ThemeDimens.system_tab_width,
            height: ThemeDimens.system_tab_height,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
                color: color,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(ThemeDimens.system_tab_radius))),
            child: Text(
              text,
              style: TextStyle(
                  color: textColor, fontSize: ThemeDimens.font_size_medium),
            )),
      ),
    );
  }

  Widget buildPage(SystemViewModel viewModel) {
    return Expanded(
        child: PageView.builder(
      itemCount: viewModel.pageList.length,
      controller: viewModel.pageController,
      physics: const NeverScrollableScrollPhysics(), //静止PageView滑动
      itemBuilder: (BuildContext context, int index) {
        return viewModel.pageList[index];
      },
    ));
  }
}
