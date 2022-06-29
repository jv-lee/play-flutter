import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/6/29
/// @description
class AppPopupMenuDivider<T> extends PopupMenuEntry<T> {
  @override
  final double height;
  final Color color;

  const AppPopupMenuDivider({Key? key, required this.height, required this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopupMenuDividerState();

  @override
  bool represents(T? value) => false;

}

class _PopupMenuDividerState extends State<AppPopupMenuDivider> {
  @override
  Widget build(BuildContext context) {
    return Divider(height: widget.height, color: widget.color,);
  }

}
