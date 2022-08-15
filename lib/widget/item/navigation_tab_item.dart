import 'package:flutter/material.dart';
import 'package:playflutter/model/entity/navigation_tab.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class NavigationTabItem extends StatefulWidget {
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
  State<StatefulWidget> createState() => _NavigationTabItemState();
}

class _NavigationTabItemState extends State<NavigationTabItem> {
  @override
  Widget build(BuildContext context) {
    Color textColor = widget.isSelected
        ? Theme.of(context).hoverColor
        : Theme.of(context).primaryColor;
    Color tabColor =
        widget.isSelected ? Theme.of(context).focusColor : Colors.transparent;

    // 包裹row让内部text自适应宽度
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          height: ThemeDimens.systemNavigationTabHeight,
          padding: const EdgeInsets.only(
              top: ThemeDimens.offsetMedium, bottom: ThemeDimens.offsetMedium),
          child: InkWell(
              onTap: () => {
                    if (widget.onItemClick != null)
                      {widget.onItemClick!(widget.navigationTab)}
                  },
              borderRadius: BorderRadius.circular(ThemeDimens.systemTabRadius),
              child: Container(
                  padding: const EdgeInsets.only(
                      left: ThemeDimens.offsetMedium,
                      right: ThemeDimens.offsetMedium),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: tabColor,
                      borderRadius:
                          BorderRadius.circular(ThemeDimens.systemTabRadius)),
                  child: Text(widget.navigationTab.name,
                      style: TextStyle(color: textColor)))))
    ]);
  }
}
