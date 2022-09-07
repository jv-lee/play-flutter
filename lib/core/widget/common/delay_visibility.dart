import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/8/25
/// @description 延迟显示组件
class DelayVisibility extends StatefulWidget {
  final Widget child;
  final Duration? duration;

  const DelayVisibility({Key? key, required this.child, this.duration})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DelayVisibilityState();
}

class _DelayVisibilityState extends State<DelayVisibility> {
  bool visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.duration ?? const Duration(milliseconds: 100), () {
      if (mounted) setState(() => visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(visible: visible, child: widget.child);
  }
}
