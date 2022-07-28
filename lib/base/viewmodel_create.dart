import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/7/28
/// @description
class ViewModelCreator {
  static Widget create<T extends ViewModel>(
      Create<T> create, ViewBuild<T> viewBuild) {
    return ChangeNotifierProvider(
      create: create,
      child: Consumer<T>(builder: (context, viewModel, child) {
        return viewBuild(context, viewModel);
      }),
    );
  }
}

typedef ViewBuild<T extends ViewModel> = Widget Function(
    BuildContext context, T viewModel);
