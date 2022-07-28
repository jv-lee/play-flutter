// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description 所有viewModel基类
abstract class ViewModel with ChangeNotifier {
  final BuildContext context;

  ViewModel(this.context) {
    init();
  }

  @override
  void dispose() {
    unInit();
    super.dispose();
  }

  /// viewModel初始化生命周期回调
  void init();

  /// viewModel生命周期销毁回调
  void unInit();

  /// 延时执行context函数
  runViewContextDelay(RunViewContext function) {
    Future.delayed(Duration.zero).then((value) async {
      function(context);
    });
  }
}

typedef RunViewContext = Function(BuildContext context);
