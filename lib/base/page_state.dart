// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:playflutter/main.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/8/2
/// @description 具有页面生命周期的pageState
abstract class PageState<T extends StatefulWidget> extends State<T>
    with RouteAware, WidgetsBindingObserver {
  var _hasAddResumeChange = true;
  var _hasAddPauseChange = true;
  final _onResumeChange = ChangeNotifier();
  final _onPauseChange = ChangeNotifier();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ToastContext().init(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    _onResumeChange.dispose();
    _onPauseChange.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        // 应用任然托管在flutter引擎上,但是不可见.
        // 当应用处于这个状态时,引擎没有视图的运行.要不就是当引擎第一次初始化时处于attach视
        // 要不就是由于导航弹出导致的视图销毁后
        onDestroy();
        break;
      case AppLifecycleState.inactive:
        // 应用在一个不活跃的状态,不会收到用户的输入
        // 在ios上,这个状态相当于应用或者flutter托管的视图在前台不活跃状态运行.当有电话进来时候应用转到这个状态等
        // 在安卓上,这个状态相当于应用或者flutter托管的视图在前台不活跃状态运行.另外一个activity获得焦点时,应用转到这个状态.比如分屏,电话等
        // 在这状态的应用应该假设他们是可能被paused的.
        break;
      case AppLifecycleState.paused:
        //应用当前对于用户不可见,不会响应用户输入,运行在后台.
        onPause();
        break;
      case AppLifecycleState.resumed:
        // 应用可见,响应用户输入
        onResume();
        break;
    }
  }

  /// Called when the current route has been pushed.
  /// 当前的页面被push显示到用户面前 viewWillAppear.
  @override
  void didPush() {
    onResume();
  }

  /// Called when the current route has been popped off.
  /// 当前的页面被pop viewWillDisappear.
  @override
  void didPop() {
    onPause();
    onDestroy();
  }

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  /// 上面的页面被pop后当前页面被显示时 viewWillAppear.
  @override
  void didPopNext() {
    onResume();
  }

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  /// 从当前页面push到另一个页面 viewWillDisappear.
  @override
  void didPushNext() {
    onPause();
  }

  /// 页面获得焦点显示
  void onResume() {
    LogTools.log(widget.toString(), "onResume()");
    _onResumeChange.notifyListeners();
  }

  /// 页面失去焦点隐藏
  void onPause() {
    LogTools.log(widget.toString(), "onPause()");
    _onPauseChange.notifyListeners();
  }

  /// 页面销毁 原则上重写dispose方法也是一样的
  void onDestroy() {
    LogTools.log(widget.toString(), "onDestroy()");
  }

  /// 用于绑定viewModel onResume回调 首次绑定直接回调onResume 顺序问题该模式在后
  void bindResume(Function onResume) {
    if (_hasAddResumeChange) {
      _hasAddResumeChange = false;
      _onResumeChange.addListener(() => onResume());
      _onResumeChange.notifyListeners();
    }
  }

  /// 用于绑定viewModel onPause回调
  void bindPause(Function onPause) {
    if (_hasAddPauseChange) {
      _hasAddPauseChange = false;
      _onPauseChange.addListener(() => onPause());
    }
  }
}
