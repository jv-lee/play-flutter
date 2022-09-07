import 'package:flutter/cupertino.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';
import 'package:playflutter/core/tools/status_tools.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description app通用头部间隔占位元素
class AppHeaderSpacer extends StatelessWidget {
  const AppHeaderSpacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Container(height: AppHeaderSpacer.spacerHeight());

  static spacerHeight() =>
      ThemeDimens.toolbarHeight + StatusTools.getStatusHeight();

  static Widget appendHeader(int index, Widget widget) =>
      index == 0 ? Column(children: [const AppHeaderSpacer(), widget]) : widget;
}
