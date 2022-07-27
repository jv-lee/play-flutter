// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description 所有viewModel基类
abstract class ViewModel with ChangeNotifier {
  State<dynamic>? view;

  /// viewModel 绑定view视图初始化方法
  void bindView(State<dynamic> viewState) {
    view = viewState;
    init();
  }

  /// viewModel 解除绑定view视图方法
  void unBindView() {
    view = null;
    unInit();
  }

  /// viewModel初始化生命周期回调
  void init();

  /// viewModel生命周期销毁回调
  void unInit();

  /// 通过页面单独创建时 ViewModelStateCreate时调用该方法更新view状态
  postViewState() {
    view?.setState(() {});
  }

  /// 通过页面单独创建时 ViewModelStateCreate时调用该方法更新view状态
  setViewState(Function function) {
    view?.setState(() {
      function();
    });
  }

  runViewContext(RunViewContext function) {
    if (view?.context != null) {
      function(view?.context as BuildContext);
    }
  }

  runViewContextDelay(RunViewContext function) {
    Future.delayed(Duration.zero).then((value) async {
      runViewContext(function);
    });
  }
}

typedef RunViewContext = Function(BuildContext context);
