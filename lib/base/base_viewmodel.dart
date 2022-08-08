// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description 所有viewModel基类
abstract class BaseViewModel with ChangeNotifier {
  final BuildContext context;

  BaseViewModel(this.context) {
    init();
  }

  @override
  void dispose() {
    onCleared();
    super.dispose();
  }

  /// viewModel初始化
  void init();

  /// viewModel销毁时
  void onCleared();

  /// 创建viewModel的页面获得焦点显示时回调
  void onResume() {}

  /// 创建viewModel的页面失去焦点隐藏时回调
  void onPause() {}

  /// 执行context函数（一般在viewModel初始化代码方法内调用，通过zero延时达到初始化时期获取路由参数正确）
  /// [function] 执行函数
  runViewContext(RunViewContext function) {
    Future.delayed(Duration.zero).then((value) async {
      function(context);
    });
  }

  /// 延时执行context函数
  /// [duration] 延时时长
  /// [function] 执行函数
  runViewContextDelay(Duration duration, RunViewContext function) {
    Future.delayed(duration).then((value) async {
      function(context);
    });
  }
}

typedef RunViewContext = Function(BuildContext context);

typedef ViewBuild<T extends BaseViewModel> = Widget Function(
    BuildContext context, T viewModel);
