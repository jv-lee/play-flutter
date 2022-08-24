import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/extensions/common_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description app通用title控件 带action按钮
class AppTextActionBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            left: ThemeDimens.offsetLarge, right: ThemeDimens.offsetLarge),
        width: double.infinity,
        height: ThemeDimens.toolbarHeight,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ThemeDimens.fontSizeLargeXX,
                color: Theme.of(context).primaryColorLight),
          ),
          Material(
              child: InkWell(
                  onTap: () => {onNavigationClick.checkNullInvoke()},
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                      width: 36,
                      height: 36,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).focusColor,
                          shape: BoxShape.circle),
                      child: SvgPicture.asset(navigationSvgPath))))
        ]));
  }
}
