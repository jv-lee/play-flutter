import 'package:flutter/material.dart';
import 'package:playflutter/core/widget/common/floating_container_mixin.dart';

/// @author jv.lee
/// @date 2022/9/22
/// @description 悬浮容器 支持手势拖动
class FloatingContainer extends StatefulWidget {
  final ReindexType reindexType;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry margin;

  final double width;
  final double height;
  final Widget child;

  const FloatingContainer(
      {Key? key,
      this.reindexType = ReindexType.move,
      this.alignment = Alignment.topLeft,
      this.margin = EdgeInsets.zero,
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
      changePosition(
          constraints, widget.reindexType, widget.width, widget.height,
          alignment: widget.alignment, margin: widget.margin);
      return Transform.translate(
          offset: moveOffset(),
          child: Listener(
              onPointerMove: (event) => changeOffset(event),
              onPointerUp: (event) => changeUp(event),
              onPointerCancel: (event) => changeUp(event),
              child: Container(
                  width: widget.width,
                  height: widget.height,
                  alignment: widget.alignment,
                  margin: widget.margin,
                  child: SizedBox(
                      width: widget.width,
                      height: widget.height,
                      child: widget.child))));
    });
  }
}

enum ReindexType {
  // 不限制复位自由摆放
  move,
  // x，y轴同时开启复位
  reindexXY,
  // x轴开启复位
  reindexX,
  // y轴开启复位
  reindexY
}
