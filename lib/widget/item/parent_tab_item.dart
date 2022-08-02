import 'package:flutter/material.dart';
import 'package:playflutter/entity/parent_tab.dart';
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
            Text(
              widget.parentTab.name,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: ThemeDimens.font_size_medium,
                  fontWeight: FontWeight.bold),
            ),
            _buildDivider(),
            Text(
              widget.parentTab.formHtmlLabels(),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: ThemeDimens.font_size_small),
            ),
            _buildDivider(),
            SizedBox(
              width: double.infinity,
              child: Text(
                ThemeStrings.system_more_text,
                style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontSize: ThemeDimens.font_size_small_x,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              ),
            )
          ],
        ));
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(
          top: ThemeDimens.offset_medium, bottom: ThemeDimens.offset_medium),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
