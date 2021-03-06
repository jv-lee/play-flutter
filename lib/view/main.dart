import 'package:flutter/material.dart';
import 'package:playflutter/view/home/home.dart';
import 'package:playflutter/view/me/me.dart';
import 'package:playflutter/view/square/square.dart';
import 'package:playflutter/view/system/system.dart';
import 'package:playflutter/theme/theme_icons.dart';
import 'package:playflutter/widget/common/app_back_pop_scope.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 首页容器类
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<MainPage> {
  int _tabIndex = 0;
  final _pageList = const [HomePage(), SquarePage(), SystemPage(), MePage()];
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackPopScope(
        child: Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: PageView.builder(
          itemCount: _pageList.length,
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(), //静止PageView滑动
          itemBuilder: (BuildContext context, int index) {
            return _pageList[index];
          }),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(ThemeIcons.home_normal),
                activeIcon: Icon(ThemeIcons.home_press),
                label: "home"),
            BottomNavigationBarItem(
                icon: Icon(ThemeIcons.square_normal),
                activeIcon: Icon(ThemeIcons.square_press),
                label: "square"),
            BottomNavigationBarItem(
                icon: Icon(ThemeIcons.system_normal),
                activeIcon: Icon(ThemeIcons.system_press),
                label: "system"),
            BottomNavigationBarItem(
                icon: Icon(ThemeIcons.me_normal),
                activeIcon: Icon(ThemeIcons.me_press),
                label: "me"),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _tabIndex,
          iconSize: 28.0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
              _pageController.jumpToPage(index);
            });
          }),
    ));
  }
}
