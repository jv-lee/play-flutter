import 'package:flutter/material.dart';
import 'package:playflutter/tools/status_tools.dart';
import 'package:playflutter/widget/common/app_header_spacer.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description app通用头部容器（可带模糊背景渐变）
class AppHeaderContainer extends StatefulWidget {
  final Widget child;
  final bool headerBrush;

  const AppHeaderContainer(
      {Key? key, required this.child, this.headerBrush = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppHeaderContainerState();
  }
}

class _AppHeaderContainerState extends State<AppHeaderContainer> {
  @override
  Widget build(BuildContext context) {
    var content = Column(
      children: [
        Container(
          height: StatusTools.getStatusHeight(),
        ),
        widget.child
      ],
    );
    if (widget.headerBrush) {
      return Container(
        height: AppHeaderSpacer.spacerHeight(),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Theme.of(context).backgroundColor,
              Theme.of(context).backgroundColor,
              Theme.of(context).backgroundColor,
              Theme.of(context).backgroundColor,
              Theme.of(context).backgroundColor,
              Theme.of(context).canvasColor
            ])),
        child: content,
      );
    } else {
      return content;
    }
  }
}
