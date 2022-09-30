import 'package:flutter/material.dart';
import 'package:playflutter/core/widget/common/floating_container_mixin.dart';

/// @author jv.lee
/// @date 2022/9/22
/// @description 悬浮容器 支持手势拖动
class FloatingContainer extends StatefulWidget {
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Decoration? decoration;

  final double width;
  final double height;
  final Widget child;

  const FloatingContainer(
      {Key? key,
      this.alignment,
      this.padding,
      this.margin,
      this.color,
      this.decoration,
      required this.width,
      required this.height,
      required this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FloatingContainerState();
}

class _FloatingContainerState extends State<FloatingContainer>
    with FloatingContainerMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      changePosition(constraints, widget.width, widget.height,
          alignment: widget.alignment, margin: widget.margin);
      return Transform.translate(
          offset: rectOffset(),
          child: Listener(
              onPointerMove: (event) => changeOffset(event),
              onPointerUp: (event) => changeUp(event),
              onPointerCancel: (event) => changeUp(event),
              child: Container(
                  width: widget.width,
                  height: widget.height,
                  alignment: widget.alignment,
                  padding: widget.padding,
                  margin: widget.margin,
                  color: widget.color,
                  decoration: widget.decoration,
                  child: SizedBox(
                      width: widget.width,
                      height: widget.height,
                      child: widget.child))));
    });
  }
}
