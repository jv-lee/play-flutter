import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/9/22
/// @description 悬浮容器 支持手势拖动
class FloatingContainer extends StatefulWidget {
  final ReindexType reindexType; // 复位回弹模式
  final bool limitBound; // 是否限制拖动出容器外
  final AlignmentGeometry alignment; // 对齐方式
  final EdgeInsetsGeometry margin; // 上下左右间距值

  final double width;
  final double height;
  final Widget child;

  const FloatingContainer(
      {Key? key,
      this.reindexType = ReindexType.reindexX,
      this.limitBound = false,
      this.alignment = Alignment.bottomRight,
      this.margin = EdgeInsets.zero,
      required this.width,
      required this.height,
      required this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FloatingContainerState();
}

class _FloatingContainerState extends State<FloatingContainer>
    with FloatingContainerMixin, SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      changeParentSize(constraints);
      return Transform.translate(
          offset: moveOffset(),
          child: Listener(
              onPointerMove: (event) => changeOffset(event),
              onPointerUp: (event) => changeUp(event),
              onPointerCancel: (event) => changeUp(event),
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: widget.alignment,
                  margin: widget.margin,
                  child: SizedBox(
                      width: widget.width,
                      height: widget.height,
                      child: widget.child))));
    });
  }
}

/// [FloatingContainer] 容器复位回弹动画type
/// [ReindexType.move] 不限制复位自由摆放
/// [ReindexType.reindexXY] x，y轴同时开启复位
/// [ReindexType.reindexX] x轴开启复位
/// [ReindexType.reindexY] y轴开启复位
enum ReindexType { move, reindexXY, reindexX, reindexY }

mixin FloatingContainerMixin<T extends StatefulWidget> on State<T> {
  bool _hasMove = false; // 当前是否移动过
  Offset _offset = const Offset(0, 0);

  double _parentWidth = 0; // 父容器宽度
  double _parentHeight = 0; // 父容器高度

  double _startX = 0; // 当前view起始x坐标
  double _startY = 0; // 当前view起始y坐标
  double _currentX = 0; // 当前view移动后的x坐标
  double _currentY = 0; // 当前view移动后的y坐标

  double _parentLeft = 0; // 父容器左边界坐标
  double _parentTop = 0; // 父亲容器上边界坐标
  double _parentRight = 0; // 父容器右边界坐标
  double _parentBottom = 0; // 父容器底边界坐标

  Offset moveOffset() => _offset; // 实时平移offset

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 100),
        vsync: this as TickerProvider);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void changeParentSize(BoxConstraints constraints) {
    _runWithView((widget) {
      final margin = widget.margin as EdgeInsets;
      final alignment = widget.alignment as Alignment;
      _parentWidth = constraints.maxWidth;
      _parentHeight = constraints.maxHeight;

      _parentLeft = 0 + margin.left;
      _parentTop = 0 + margin.top;
      _parentRight = _parentWidth - margin.right;
      _parentBottom = _parentHeight - margin.bottom;

      if (alignment == Alignment.topLeft) {
        _startX = 0 + margin.left;
        _startY = 0 + margin.top;
      } else if (alignment == Alignment.topCenter) {
        _startX = (_parentWidth / 2) - (widget.width / 2);
        _startY = 0 + margin.top;
      } else if (alignment == Alignment.topRight) {
        _startX = (_parentWidth - widget.width) - margin.right;
        _startY = 0 + margin.top;
      } else if (alignment == Alignment.centerLeft) {
        _startX = 0 + margin.left;
        _startY = (_parentHeight / 2) - (widget.height / 2);
      } else if (alignment == Alignment.center) {
        _startX = ((_parentWidth / 2) - (widget.width / 2));
        _startY = (_parentHeight / 2) - (widget.height / 2);
      } else if (alignment == Alignment.centerRight) {
        _startX = (_parentWidth - widget.width) - margin.right;
        _startY = (_parentHeight / 2) - (widget.height / 2);
      } else if (alignment == Alignment.bottomLeft) {
        _startX = 0 + margin.left;
        _startY = (_parentHeight - widget.height) - margin.bottom;
      } else if (alignment == Alignment.bottomCenter) {
        _startX = ((_parentWidth / 2) - (widget.width / 2));
        _startY = (_parentHeight - widget.height) - margin.bottom;
      } else if (alignment == Alignment.bottomRight) {
        _startX = (_parentWidth - widget.width) - margin.right;
        _startY = (_parentHeight - widget.height) - margin.bottom;
      }
    });
  }

  void changeOffset(PointerEvent event) {
    _hasMove = true; // 设置移动标志位
    _runWithView((widget) {
      final margin = widget.margin as EdgeInsets;
      var offsetX = _offset.dx + event.delta.dx;
      var offsetY = _offset.dy + event.delta.dy;

      _currentX = _startX + offsetX;
      _currentY = _startY + offsetY;

      // 是否限制可拖动出边界
      if (widget.limitBound) {
        if (_currentX < _parentLeft - margin.left) {
          offsetX = -(_startX - (_parentLeft - margin.left));
        } else if (_currentX > ((_parentRight + margin.right) - widget.width)) {
          offsetX = ((_parentRight + margin.right) - widget.width) - _startX;
        }

        if (_currentY < _parentTop - margin.top) {
          offsetY = -(_startY - (_parentTop - margin.top));
        } else if (_currentY >
            ((_parentBottom + margin.bottom) - widget.height)) {
          offsetY = ((_parentBottom + margin.bottom) - widget.height) - _startY;
        }
      }

      setState(() => _offset = Offset(offsetX, offsetY));
    });
  }

  void changeUp(PointerEvent event) {
    if (!_hasMove) return; // 未移动过无需处理复位
    _runWithView((widget) {
      if (widget.reindexType == ReindexType.move) {
        _reindexMove();
      } else if (widget.reindexType == ReindexType.reindexXY) {
        _reindexXYUp();
      } else if (widget.reindexType == ReindexType.reindexX) {
        _reindexXUp();
      } else if (widget.reindexType == ReindexType.reindexY) {
        _reindexYUp();
      }
    });
  }

  void _reindexMove() {
    _runWithView((widget) {
      var x = _offset.dx;
      var y = _offset.dy;

      // 超过父容器左边
      if (_currentX < _parentLeft) {
        x = -(_startX - _parentLeft);
        // 超过父容器右边
      } else if (_currentX > (_parentRight - widget.width)) {
        x = (_parentRight - widget.width) - _startX;
      }

      // 超过父容器顶部
      if (_currentY < _parentTop) {
        y = -(_startY - _parentTop);
        // 超过父容器底部
      } else if (_currentY > (_parentBottom - widget.height)) {
        y = (_parentBottom - widget.height) - _startY;
      }

      _startReindexAnimation(Offset(x, y));
    });
  }

  void _reindexXYUp() {
    _startReindexAnimation(Offset.zero);
  }

  void _reindexXUp() {
    _runWithView((widget) {
      var x = 0.0;
      var y = _offset.dy;

      // 当前view中心点靠近右边界
      if ((_currentX + (widget.width / 2)) >= (_parentWidth / 2)) {
        x = (_parentRight - widget.width) - _startX;

        // 当前view中心点靠近左边界
      } else {
        x = -(_startX - _parentLeft);
      }

      // 超过父容器顶部
      if (_currentY < _parentTop) {
        y = -(_startY - _parentTop);
        // 超过父容器底部
      } else if (_currentY > (_parentBottom - widget.height)) {
        y = (_parentBottom - widget.height) - _startY;
      }

      _startReindexAnimation(Offset(x, y));
    });
  }

  void _reindexYUp() {
    _runWithView((widget) {
      var x = _offset.dx;
      var y = 0.0;

      // 超过父容器左边
      if (_currentX < _parentLeft) {
        x = -(_startX - _parentLeft);
        // 超过父容器右边
      } else if (_currentX > (_parentRight - widget.width)) {
        x = (_parentRight - widget.width) - _startX;
      }

      // 当前view中心点靠近下边界
      if ((_currentY + (widget.height / 2)) >= (_parentHeight / 2)) {
        y = (_parentBottom - widget.height) - _startY;

        // 当前view中心点靠近上边界
      } else {
        y = -(_startY - _parentTop);
      }

      _startReindexAnimation(Offset(x, y));
    });
  }

  void _startReindexAnimation(Offset offset) {
    var animation = FractionalOffsetTween(
            begin: FractionalOffset(_offset.dx, _offset.dy),
            end: FractionalOffset(offset.dx, offset.dy))
        .animate(_animationController);

    animation.addListener(() => setState(() => _offset = Offset(
        animation.value?.dx ?? offset.dx, animation.value?.dy ?? offset.dy)));
    _animationController.reset();
    _animationController.forward();
  }

  void _runWithView(Function(FloatingContainer widget) block) {
    block((this as _FloatingContainerState).widget);
  }
}
