import 'package:flutter/material.dart';
import 'package:playflutter/entity/navigation_tab.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class NavigationTabItem extends StatefulWidget {
  final NavigationTab navigationTab;
  final Function(NavigationTab)? onItemClick;

  const NavigationTabItem({
    Key? key,
    required this.navigationTab,
    this.onItemClick,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigationTabItemState();
}

class _NavigationTabItemState extends State<NavigationTabItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Text(widget.navigationTab.name),
    );
  }
}
