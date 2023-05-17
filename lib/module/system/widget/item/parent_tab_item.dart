import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/data_format_extensions.dart';
import 'package:playflutter/core/model/entity/parent_tab.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/widget/common/card_item_container.dart';
import 'package:playflutter/module/system/theme/theme_system.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 系统模块顶部 tabItem控件
class ParentTabItem extends StatelessWidget {
  final ParentTab parentTab;
  final Function(ParentTab) onItemClick;

  const ParentTabItem({
    Key? key,
    required this.parentTab,
    required this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItemContainer(
        onItemClick: () => {onItemClick(parentTab)},
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(parentTab.name,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontSize: ThemeCommon.dimens.fontSizeMedium,
                      fontWeight: FontWeight.bold)),
              buildDivider(context),
              Text(parentTab.formHtmlLabels(),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: ThemeCommon.dimens.fontSizeSmall)),
              buildDivider(context),
              SizedBox(
                  width: double.infinity,
                  child: Text(ThemeSystem.strings.moreText,
                      style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontSize: ThemeCommon.dimens.fontSizeSmallX,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end))
            ]));
  }

  Widget buildDivider(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            top: ThemeCommon.dimens.offsetMedium,
            bottom: ThemeCommon.dimens.offsetMedium),
        width: double.infinity,
        height: 1,
        color: Theme.of(context).scaffoldBackgroundColor);
  }
}
