import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// @author jv.lee
/// @date 2022/8/9
/// @description 透明Scaffold，内容可以直接填充整个屏幕无statusBar间距，无toolbar
/// [color] 当前页面顶部状态栏应该呈现的颜色（根据该颜色自动适配statusIcon颜色,默认使用scaffold背景色）
class TransparentScaffold extends StatelessWidget {
  final Widget child;
  final Color? color;

  const TransparentScaffold({Key? key, this.color, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: _changeSystemUiOverlayStyle(
              color ?? Theme.of(context).scaffoldBackgroundColor),
        ),
        body: child);
  }

  _changeSystemUiOverlayStyle(Color color) {
    if (ThemeData.estimateBrightnessForColor(color) == Brightness.dark) {
      return SystemUiOverlayStyle.light;
    } else {
      return SystemUiOverlayStyle.dark;
    }
  }
}
