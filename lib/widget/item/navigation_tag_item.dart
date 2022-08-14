import 'package:flutter/material.dart';
import 'package:playflutter/model/entity/navigation_tab.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class NavigationTagItem extends StatefulWidget {
  final NavigationTab navigationTab;
  final Function(Articles)? onItemClick;

  const NavigationTagItem({
    Key? key,
    required this.navigationTab,
    this.onItemClick,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigationTagItemState();
}

class _NavigationTagItemState extends State<NavigationTagItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(ThemeDimens.offsetLarge),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.navigationTab.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: ThemeDimens.fontSizeMedium,
                  fontWeight: FontWeight.bold)),
          Padding(
              padding: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
              child: buildTagFlowList())
        ]));
  }

  Widget buildTagFlowList() {
    List<Widget> widgets = [];
    for (var element in widget.navigationTab.articles) {
      widgets.add(Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeDimens.systemTabRadius)),
          child: InkWell(
              onTap: () => {
                    if (widget.onItemClick != null)
                      {widget.onItemClick!(element)}
                  },
              borderRadius: BorderRadius.circular(ThemeDimens.systemTabRadius),
              child: Padding(
                  padding: const EdgeInsets.all(ThemeDimens.offsetMedium),
                  child: Text(element.title,
                      style: TextStyle(
                          fontSize: ThemeDimens.fontSizeSmall,
                          color: Theme.of(context).primaryColor))))));
    }
    return Wrap(spacing: 2, runSpacing: -2, children: widgets);
  }
}
