import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/model/entity/navigation_tab.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';
import 'package:playflutter/module/system/theme/theme_dimens_system.dart';

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
          height: ThemeDimensSystem.navigationTabHeight,
          padding: const EdgeInsets.only(
              top: ThemeDimens.offsetMedium, bottom: ThemeDimens.offsetMedium),
          child: InkWell(
              onTap: () => onItemClick?.run((self) => self(navigationTab)),
              borderRadius: BorderRadius.circular(ThemeDimensSystem.tabRadius),
              child: Container(
                  padding: const EdgeInsets.only(
                      left: ThemeDimens.offsetMedium,
                      right: ThemeDimens.offsetMedium),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: tabColor,
                      borderRadius:
                          BorderRadius.circular(ThemeDimensSystem.tabRadius)),
                  child: Text(navigationTab.name,
                      style: TextStyle(color: textColor)))))
    ]);
  }
}
