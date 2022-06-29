import 'package:flutter/cupertino.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/tools/status_tools.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description app通用头部间隔占位元素
class AppHeaderSpacer extends StatefulWidget {
  const AppHeaderSpacer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppHeaderSpacerState();
  }

  static spacerHeight() {
    return ThemeDimens.toolbar_height + StatusTools.getStatusHeight();
  }
}

class _AppHeaderSpacerState extends State<AppHeaderSpacer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeaderSpacer.spacerHeight(),
    );
  }
}
