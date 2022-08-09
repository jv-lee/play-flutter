import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/8/9
/// @description 透明Scaffold 可主动设置appBar背景颜色适应全屏填充页面 （statusBarIcon根据appBar背景色自动适配颜色）
class TransparentScaffold extends StatelessWidget {
  final Color? color;
  final Widget child;

  const TransparentScaffold({Key? key, this.color, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: color ?? Theme.of(context).scaffoldBackgroundColor,
        ),
        body: child);
  }
}
