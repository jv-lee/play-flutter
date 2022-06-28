import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description app通用title控件 带导航按钮
class AppGradientTextBar extends StatefulWidget {
  final String title;
  final String svgPath;

  const AppGradientTextBar(
      {Key? key, required this.title, required this.svgPath})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AppGradientTextBarState();
  }
}

class AppGradientTextBarState extends State<AppGradientTextBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: ThemeDimens.offset_large, right: ThemeDimens.offset_large),
      child: SizedBox(
        width: double.infinity,
        height: ThemeDimens.toolbar_height,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            widget.title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ThemeDimens.font_size_large_xx,
                color: Theme.of(context).primaryColorDark),
          ),
          Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: Theme.of(context).focusColor, shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(widget.svgPath),
              ))
        ]),
      ),
    );
  }
}
