import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/data_format_extensions.dart';
import 'package:playflutter/core/model/entity/parent_tab.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';
import 'package:playflutter/core/widget/common/card_item_container.dart';
import 'package:playflutter/module/system/theme/theme_system.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
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
                      fontSize: ThemeDimens.fontSizeMedium,
                      fontWeight: FontWeight.bold)),
              buildDivider(context),
              Text(parentTab.formHtmlLabels(),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: ThemeDimens.fontSizeSmall)),
              buildDivider(context),
              SizedBox(
                  width: double.infinity,
                  child: Text(ThemeSystem.strings.moreText,
                      style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontSize: ThemeDimens.fontSizeSmallX,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end))
            ]));
  }

  Widget buildDivider(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
            top: ThemeDimens.offsetMedium, bottom: ThemeDimens.offsetMedium),
        width: double.infinity,
        height: 1,
        color: Theme.of(context).scaffoldBackgroundColor);
  }
}
