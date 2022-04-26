import 'package:flutter/material.dart';
import 'package:playflutter/tools/status_tools.dart';
import 'package:playflutter/view/page/home/home.dart';
import 'package:playflutter/view/page/me/me.dart';
import 'package:playflutter/view/page/square/square.dart';
import 'package:playflutter/view/page/system/system.dart';
import 'package:playflutter/theme/theme_icons.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<MainPage> {
  int _tabIndex = 0;
  var _pageList = [HomePage(), SquarePage(), SystemPage(), MePage()];
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    //监听第一帧绘制完毕后设置沉浸式状态栏
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      StatusTools.transparentStatusBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          itemCount: _pageList.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(), //静止PageView滑动
          itemBuilder: (BuildContext context, int index) {
            return _pageList[index];
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: Icon(ThemeIcons.home_normal),
              activeIcon: Icon(ThemeIcons.home_press),
              label: "home"),
          new BottomNavigationBarItem(
              icon: Icon(ThemeIcons.square_normal),
              activeIcon: Icon(ThemeIcons.square_press),
              label: "square"),
          new BottomNavigationBarItem(
              icon: Icon(ThemeIcons.system_normal),
              activeIcon: Icon(ThemeIcons.system_press),
              label: "system"),
          new BottomNavigationBarItem(
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
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black12,
      ),
    );
  }
}
