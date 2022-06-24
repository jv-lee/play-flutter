import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description 所有viewModel基类
abstract class ViewModel extends ChangeNotifier {
  /// viewModel 绑定view视图初始化方法
  void bindView(State<dynamic> viewState);
}
