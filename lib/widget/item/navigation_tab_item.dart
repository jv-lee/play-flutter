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
    Color textColor;
    Color tabColor;
    if (widget.isSelected) {
      textColor = Theme.of(context).hoverColor;
      tabColor = Theme.of(context).focusColor;
    } else {
      textColor = Theme.of(context).primaryColor;
      tabColor = Colors.transparent;
    }

    // 包裹row让内部text自适应宽度
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: ThemeDimens.system_navigation_tab_height,
          child: Padding(
            padding: const EdgeInsets.only(
                top: ThemeDimens.offset_medium,
                bottom: ThemeDimens.offset_medium),
            child: InkWell(
              onTap: () => {
                if (widget.onItemClick != null)
                  {widget.onItemClick!(widget.navigationTab)}
              },
              borderRadius:
                  BorderRadius.circular(ThemeDimens.system_tab_radius),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: tabColor,
                    borderRadius:
                        BorderRadius.circular(ThemeDimens.system_tab_radius)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: ThemeDimens.offset_medium,
                      right: ThemeDimens.offset_medium),
                  child: Text(
                    widget.navigationTab.name,
                    style: TextStyle(color: textColor),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
