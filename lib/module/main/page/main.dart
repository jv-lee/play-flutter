import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/widget/common/back_pop_scope.dart';
import 'package:playflutter/core/widget/common/cover_touch.dart';
import 'package:playflutter/core/widget/common/floating_container.dart';
import 'package:playflutter/module/home/theme/theme_home.dart';
import 'package:playflutter/module/main/viewmodel/main_viewmodel.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 首页容器类
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends BasePageState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<MainViewModel>(
        create: (context) => MainViewModel(context),
        viewBuild: (context, viewModel) => BackPopScope(
            child: Scaffold(
                body: Stack(children: [
                  PageView.builder(
                      itemCount: viewModel.viewStates.mainTabPages.length,
                      controller: viewModel.viewStates.pageController,
                      //静止PageView滑动
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) =>
                          viewModel.viewStates.mainTabPages[index].page),
                  buildFloatingWidget()
                ]),
                bottomNavigationBar: BottomNavigationBar(
                    items: viewModel.viewStates.mainTabPages
                        .map((e) => BottomNavigationBarItem(
                            icon: Icon(e.normalIcon),
                            activeIcon: Icon(e.pressIcon),
                            label: e.label))
                        .toList(),
                    type: BottomNavigationBarType.fixed,
                    currentIndex: viewModel.viewStates.tabIndex,
                    iconSize: 28.0,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    onTap: (index) => viewModel.changeTab(index)))));
  }

  Widget buildFloatingWidget() {
    return kDebugMode
        ? FloatingContainer(
            width: ThemeCommon.dimens.floatingIconSize,
            height: ThemeCommon.dimens.floatingIconSize,
            margin: EdgeInsets.all(ThemeCommon.dimens.offsetLarge),
            child: CoverTouch(
                radius:
                    Radius.circular(ThemeCommon.dimens.floatingIconSize / 2),
                onTap: () => Toast.show(ThemeHome.strings.headerText),
                child: Image.asset(ThemeCommon.images.launcherRoundPng)))
        : Container();
  }
}
