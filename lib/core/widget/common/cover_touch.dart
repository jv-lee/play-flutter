import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/9/28
/// @description 遮罩点击效果容器
class CoverTouch extends StatefulWidget {
  final Widget child;
  final Function onTap;
  final Radius radius;

  const CoverTouch(
      {Key? key,
      this.radius = Radius.zero,
      required this.child,
      required this.onTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CoverTouchState();
}

class _CoverTouchState extends State<CoverTouch> {
  var opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Stack(children: [
        widget.child,
        Opacity(
            opacity: opacity,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(widget.radius))))
      ]),
      onTap: () => widget.onTap(),
      onTapDown: (details) => _onFocus(),
      onTapUp: (details) => _unFocus(),
      onTapCancel: () => _unFocus(),
    );
  }

  void _onFocus() {
    setState(() {
      opacity = 1.0;
    });
  }

  void _unFocus() {
    setState(() {
      opacity = 0.0;
    });
  }
}
