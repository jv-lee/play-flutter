import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/extensions/common_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description app通用title控件 带action按钮
class AppTextActionBar extends StatefulWidget {
  final String title;
  final String navigationSvgPath;
  final Function? onNavigationClick;

  const AppTextActionBar(
      {Key? key,
      required this.title,
      required this.navigationSvgPath,
      this.onNavigationClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppTextActionBarState();
}

class _AppTextActionBarState extends State<AppTextActionBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            left: ThemeDimens.offsetLarge, right: ThemeDimens.offsetLarge),
        child: SizedBox(
            width: double.infinity,
            height: ThemeDimens.toolbarHeight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ThemeDimens.fontSizeLargeXX,
                        color: Theme.of(context).primaryColorLight),
                  ),
                  Material(
                      child: InkWell(
                          onTap: () =>
                              {widget.onNavigationClick.checkNullInvoke()},
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).focusColor,
                                  shape: BoxShape.circle),
                              child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: SvgPicture.asset(
                                      widget.navigationSvgPath)))))
                ])));
  }
}
