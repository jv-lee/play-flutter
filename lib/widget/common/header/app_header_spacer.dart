import 'package:flutter/cupertino.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/tools/status_tools.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description app通用头部间隔占位元素
class AppHeaderSpacer extends StatefulWidget {
  const AppHeaderSpacer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppHeaderSpacerState();

  static spacerHeight() =>
      ThemeDimens.toolbarHeight + StatusTools.getStatusHeight();

  static Widget appendHeader(int index, Widget widget) =>
      index == 0 ? Column(children: [const AppHeaderSpacer(), widget]) : widget;
}

class _AppHeaderSpacerState extends State<AppHeaderSpacer> {
  @override
  Widget build(BuildContext context) {
    return Container(height: AppHeaderSpacer.spacerHeight());
  }
}
