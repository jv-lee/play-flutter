// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description 所有viewModel基类
abstract class ViewModel extends ChangeNotifier {
  State<dynamic>? view;

  /// viewModel 绑定view视图初始化方法
  void bindView(State<dynamic> viewState) {
    view = viewState;
    init();
  }

  void init();

  postViewState() {
    view?.setState(() {});
  }

  setViewState(Function function) {
    view?.setState(() {
      function();
    });
  }
}
