import 'package:flutter/widgets.dart';
import 'package:playflutter/base/viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description ViewModelStateCreate 封装类 不依赖全局配置，在当前页面单独创建与销毁
abstract class ViewModelStateCreate<V extends StatefulWidget,
    VM extends ViewModel> extends State<V> {
  late VM _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = createVM();
    _viewModel.bindView(this);
  }

  @override
  void deactivate() {
    _viewModel.unBindView();
    _viewModel.dispose();
    super.deactivate();
  }

  VM findVM() => _viewModel;

  VM createVM();
}
