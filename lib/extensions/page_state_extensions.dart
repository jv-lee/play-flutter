import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/8/2
/// @description PageState扩展函数类
extension PageStateExtensions on BasePageState {
  /// 创建viewModelWidget树
  /// [create] viewModel构建实例
  /// [viewBuild] widget构建方法
  Widget buildViewModel<T extends BaseViewModel>(
      {required Create<T> create, required ViewBuild<T> viewBuild}) {
    return ChangeNotifierProvider(
      create: create,
      child: Consumer<T>(builder: (context, viewModel, child) {
        viewModel.bindViewState(this);
        bindResume(() => viewModel.onResume());
        bindPause(() => viewModel.onPause());
        return viewBuild(context, viewModel);
      }),
    );
  }
}
