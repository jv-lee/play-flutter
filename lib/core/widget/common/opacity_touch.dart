import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/9/28
/// @description 透明度点击效果容器
class OpacityTouch extends StatefulWidget {
  final Widget child;

  const OpacityTouch({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OpacityTouchState();
}

class _OpacityTouchState extends State<OpacityTouch> {
  var opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Opacity(
        opacity: opacity,
        child: widget.child,
      ),
      onTapDown: (details) => _onFocus(),
      onTapUp: (details) => _unFocus(),
      onTapCancel: () => _unFocus(),
    );
  }

  void _onFocus() {
    setState(() {
      opacity = 0.5;
    });
  }

  void _unFocus() {
    setState(() {
      opacity = 1.0;
    });
  }
}
