import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description 所有viewModel基类
abstract class BaseViewModel with ChangeNotifier {
  final BuildContext context;
  bool _isDisposed = false;

  BaseViewModel(this.context) {
    init();
  }

  @override
  void dispose() {
    _isDisposed = true;
    onCleared();
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (isDisposed()) return;
    super.notifyListeners();
  }

  /// viewModel初始化
  void init();

  /// viewModel销毁时
  void onCleared();

  /// 创建viewModel的页面获得焦点显示时回调
  void onResume() {}

  /// 创建viewModel的页面失去焦点隐藏时回调
  void onPause() {}

  /// 判断当前持有viewModel的view树是否已经解绑
  bool isDisposed() => _isDisposed;

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
  runViewContextDelay(RunViewContext function,{Duration? duration}) {
    Future.delayed(duration ?? const Duration(milliseconds: 100)).then((value) async {
      function(context);
    });
  }
}

/// 执行带context的函数，可用于延时执行等跨作用域函数
typedef RunViewContext = Function(BuildContext context);

/// PageState build widget时创建viewModel
typedef ViewBuild<T extends BaseViewModel> = Widget Function(
    BuildContext context, T viewModel);

/// PageState 向下传递时在内部构建 viewModel时用到
typedef StateBuild<T extends BasePageState> = Widget Function(T state,BuildContext context);
