import 'package:flutter/material.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/tools/status_tools.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description
class AppHeaderContainer extends StatefulWidget {
  final Widget child;
  final bool headerBrush;

  AppHeaderContainer({required this.child, this.headerBrush = true});

  @override
  State<StatefulWidget> createState() {
    return AppHeaderContainerState();
  }
}

class AppHeaderContainerState extends State<AppHeaderContainer> {
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
        height: ThemeDimens.toolbar_height + StatusTools.getStatusHeight(),
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
