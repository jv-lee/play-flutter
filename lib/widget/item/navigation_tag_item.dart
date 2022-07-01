import 'package:flutter/material.dart';
import 'package:playflutter/entity/navigation_tab.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class NavigationTagItem extends StatefulWidget {
  final NavigationTab navigationTab;
  final Function(NavigationTab)? onItemClick;

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
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Text(widget.navigationTab.name),
    );
  }
}
