import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/model/entity/navigation_tab.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/module/system/theme/theme_system.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 导航模块 导航内容页tagItem控件
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
        padding: EdgeInsets.all(ThemeCommon.dimens.offsetLarge),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(navigationTab.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: ThemeCommon.dimens.fontSizeMedium,
                  fontWeight: FontWeight.bold)),
          Padding(
              padding: EdgeInsets.only(top: ThemeCommon.dimens.offsetMedium),
              child: buildTagFlowList(context))
        ]));
  }

  Widget buildTagFlowList(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in navigationTab.articles) {
      widgets.add(Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(ThemeSystem.dimens.tabRadius)),
          child: InkWell(
              onTap: () => onItemClick?.run((self) => self(element)),
              borderRadius: BorderRadius.circular(ThemeSystem.dimens.tabRadius),
              child: Container(
                  padding: EdgeInsets.all(ThemeCommon.dimens.offsetMedium),
                  child: Text(element.title,
                      style: TextStyle(
                          fontSize: ThemeCommon.dimens.fontSizeSmall,
                          color: Theme.of(context).primaryColor))))));
    }
    return Wrap(spacing: 2, runSpacing: -2, children: widgets);
  }
}
