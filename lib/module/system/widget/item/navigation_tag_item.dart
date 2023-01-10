import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/model/entity/navigation_tab.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';
import 'package:playflutter/module/system/theme/theme_dimens_system.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class NavigationTagItem extends StatelessWidget {
  final NavigationTab navigationTab;
  final Function(Articles)? onItemClick;

  const NavigationTagItem({
    Key? key,
    required this.navigationTab,
    this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(ThemeDimens.offsetLarge),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(navigationTab.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: ThemeDimens.fontSizeMedium,
                  fontWeight: FontWeight.bold)),
          Padding(
              padding: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
              child: buildTagFlowList(context))
        ]));
  }

  Widget buildTagFlowList(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in navigationTab.articles) {
      widgets.add(Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeDimensSystem.tabRadius)),
          child: InkWell(
              onTap: () => onItemClick?.run((self) => self(element)),
              borderRadius: BorderRadius.circular(ThemeDimensSystem.tabRadius),
              child: Container(
                  padding: const EdgeInsets.all(ThemeDimens.offsetMedium),
                  child: Text(element.title,
                      style: TextStyle(
                          fontSize: ThemeDimens.fontSizeSmall,
                          color: Theme.of(context).primaryColor))))));
    }
    return Wrap(spacing: 2, runSpacing: -2, children: widgets);
  }
}
