import 'package:flutter/material.dart';
import 'package:playflutter/base/page_state.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/8/2
/// @description PageState扩展函数类
extension PageStateExtensions on PageState {

  /// 创建viewModelWidget树
  /// [create] viewModel构建方法
  /// [viewBuild] widget构建方法
  Widget createViewModel<T extends ViewModel>(
      Create<T> create, ViewBuild<T> viewBuild) {
    return ChangeNotifierProvider(
      create: create,
      child: Consumer<T>(builder: (context, viewModel, child) {
        bindResume(() => viewModel.onResume());
        bindPause(() => viewModel.onPause());
        return viewBuild(context, viewModel);
      }),
    );
  }
}
