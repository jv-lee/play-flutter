import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/view/main/viewmodel/main_viewmodel.dart';
import 'package:playflutter/widget/common/app_back_pop_scope.dart';

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
        viewBuild: (context, viewModel) => AppBackPopScope(
            child: Scaffold(
                body: PageView.builder(
                    itemCount: viewModel.viewStates.mainTabPages.length,
                    controller: viewModel.viewStates.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    //静止PageView滑动
                    itemBuilder: (BuildContext context, int index) =>
                        viewModel.viewStates.mainTabPages[index].page),
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
}
