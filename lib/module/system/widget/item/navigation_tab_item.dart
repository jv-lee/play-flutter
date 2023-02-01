import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/model/entity/navigation_tab.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/module/system/theme/theme_system.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class NavigationTabItem extends StatelessWidget {
  final NavigationTab navigationTab;
  final bool isSelected;
  final Function(NavigationTab)? onItemClick;

  const NavigationTabItem({
    Key? key,
    required this.navigationTab,
    this.isSelected = false,
    this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = isSelected
        ? Theme.of(context).hoverColor
        : Theme.of(context).primaryColor;
    Color tabColor =
        isSelected ? Theme.of(context).focusColor : Colors.transparent;

    // 包裹row让内部text自适应宽度
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          height: ThemeSystem.dimens.navigationTabHeight,
          padding: EdgeInsets.only(
              top: ThemeCommon.dimens.offsetMedium,
              bottom: ThemeCommon.dimens.offsetMedium),
          child: InkWell(
              onTap: () => onItemClick?.run((self) => self(navigationTab)),
              borderRadius: BorderRadius.circular(ThemeSystem.dimens.tabRadius),
              child: Container(
                  padding: EdgeInsets.only(
                      left: ThemeCommon.dimens.offsetMedium,
                      right: ThemeCommon.dimens.offsetMedium),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: tabColor,
                      borderRadius:
                          BorderRadius.circular(ThemeSystem.dimens.tabRadius)),
                  child: Text(navigationTab.name,
                      style: TextStyle(color: textColor)))))
    ]);
  }
}
