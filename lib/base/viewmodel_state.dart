import 'package:flutter/widgets.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description ViewModelState 封装类
abstract class ViewModelState<V extends StatefulWidget, VM extends ViewModel>
    extends State<V> {
  @override
  void initState() {
    super.initState();
    context.read<VM>().bindView(this);
  }

  @override
  void dispose() {
    context.read<VM>().unbindView();
    super.dispose();
  }

  VM readVM() => context.read<VM>();

  VM providerOfVM() => Provider.of<VM>(context);
}