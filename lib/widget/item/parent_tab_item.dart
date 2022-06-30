import 'package:flutter/material.dart';
import 'package:playflutter/entity/parent_tab.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class ParentTabItem extends StatefulWidget {
  final ParentTab parentTab;
  final Function(ParentTab)? onItemClick;

  const ParentTabItem({
    Key? key,
    required this.parentTab,
    this.onItemClick,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ParentTabItemState();
}

class _ParentTabItemState extends State<ParentTabItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Text(widget.parentTab.name),
    );
  }
}
