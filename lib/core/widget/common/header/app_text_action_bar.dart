import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/theme/theme_common.dart';

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
        padding: EdgeInsets.only(
            left: ThemeCommon.dimens.offsetLarge,
            right: ThemeCommon.dimens.offsetLarge),
        width: double.infinity,
        height: ThemeCommon.dimens.toolbarHeight,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ThemeCommon.dimens.fontSizeLargeXX,
                color: Theme.of(context).primaryColorLight),
          ),
          Material(
              child: InkWell(
                  onTap: () => onNavigationClick.checkNullInvoke(),
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
