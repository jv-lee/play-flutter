import 'package:flutter/material.dart';
import 'package:playflutter/model/entity/parent_tab.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/widget/common/card_item_container.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class ParentTabItem extends StatefulWidget {
  final ParentTab parentTab;
  final Function(ParentTab) onItemClick;

  const ParentTabItem({
    Key? key,
    required this.parentTab,
    required this.onItemClick,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ParentTabItemState();
}

class _ParentTabItemState extends State<ParentTabItem> {
  @override
  Widget build(BuildContext context) {
    return CardItemContainer(
        onItemClick: () => {widget.onItemClick(widget.parentTab)},
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(widget.parentTab.name,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontSize: ThemeDimens.fontSizeMedium,
                      fontWeight: FontWeight.bold)),
              buildDivider(),
              Text(widget.parentTab.formHtmlLabels(),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: ThemeDimens.fontSizeSmall)),
              buildDivider(),
              SizedBox(
                  width: double.infinity,
                  child: Text(ThemeStrings.systemMoreText,
                      style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontSize: ThemeDimens.fontSizeSmallX,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end))
            ]));
  }

  Widget buildDivider() {
    return Padding(
        padding: const EdgeInsets.only(
            top: ThemeDimens.offsetMedium, bottom: ThemeDimens.offsetMedium),
        child: Container(
            width: double.infinity,
            height: 1,
            color: Theme.of(context).scaffoldBackgroundColor));
  }
}
