// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description 所有viewModel基类
abstract class ViewModel with ChangeNotifier {
  late BuildContext? _context;

  /// viewModel 绑定view视图初始化方法
  void bindView(State<dynamic> viewState) {
    _context = viewState.context;
    init();
  }

  /// viewModel 解除绑定view视图方法
  void unBindView() {
    _context = null;
    unInit();
  }

  /// viewModel初始化生命周期回调
  void init();

  /// viewModel生命周期销毁回调
  void unInit();

  runViewContext(RunViewContext function) {
    if (_context != null) {
      function(_context as BuildContext);
    }
  }

  runViewContextDelay(RunViewContext function) {
    Future.delayed(Duration.zero).then((value) async {
      runViewContext(function);
    });
  }
}

typedef RunViewContext = Function(BuildContext context);
