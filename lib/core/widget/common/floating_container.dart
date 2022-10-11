import 'package:flutter/material.dart';

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
    with FloatingContainerMixin, SingleTickerProviderStateMixin {
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

mixin FloatingContainerMixin<T extends StatefulWidget> on State<T> {
  bool _firstBuild = true;
  ReindexType _reindexType = ReindexType.move;
  Offset _offset = const Offset(0, 0);
  EdgeInsets _margin = EdgeInsets.zero;

  double _width = 0; // 当前view宽度
  double _height = 0; // 当前view高度
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

  void changePosition(
      BoxConstraints constraints, ReindexType type, double width, double height,
      {AlignmentGeometry? alignment = Alignment.topLeft,
      EdgeInsetsGeometry? margin}) {
    if (_firstBuild) {
      _firstBuild = false;
    } else {
      return;
    }
    _reindexType = type;
    _width = width;
    _height = height;
    _parentWidth = constraints.maxWidth;
    _parentHeight = constraints.maxHeight;
    _margin = margin as EdgeInsets? ?? EdgeInsets.zero;

    _parentLeft = 0 + _margin.left;
    _parentTop = 0 + _margin.top;
    _parentRight = _parentWidth - _margin.right;
    _parentBottom = _parentHeight - _margin.bottom;

    if (alignment == Alignment.topLeft) {
      _startX = 0 + _margin.left;
      _startY = 0 + _margin.top;
    } else if (alignment == Alignment.topCenter) {
      _startX = (_parentWidth / 2) - (_width / 2);
      _startY = 0 + _margin.top;
    } else if (alignment == Alignment.topRight) {
      _startX = (_parentWidth - _width) - _margin.right;
      _startY = 0 + _margin.top;
    } else if (alignment == Alignment.centerLeft) {
      _startX = 0 + _margin.left;
      _startY = (_parentHeight / 2) - (_height / 2);
    } else if (alignment == Alignment.center) {
      _startX = ((_parentWidth / 2) - (_width / 2));
      _startY = (_parentHeight / 2) - (_height / 2);
    } else if (alignment == Alignment.centerRight) {
      _startX = (_parentWidth - width) - _margin.right;
      _startY = (_parentHeight / 2) - (_height / 2);
    } else if (alignment == Alignment.bottomLeft) {
      _startX = 0 + _margin.left;
      _startY = (_parentHeight - _height) - _margin.bottom;
    } else if (alignment == Alignment.bottomCenter) {
      _startX = ((_parentWidth / 2) - (_width / 2));
      _startY = (_parentHeight - _height) - _margin.bottom;
    } else if (alignment == Alignment.bottomRight) {
      _startX = (_parentWidth - width) - _margin.right;
      _startY = (_parentHeight - height) - _margin.bottom;
    }
  }

  void changeOffset(PointerEvent event) {
    setState(() {
      _offset =
          Offset(_offset.dx + event.delta.dx, _offset.dy + event.delta.dy);

      _currentX = _startX + _offset.dx;
      _currentY = _startY + _offset.dy;
    });
  }

  void changeUp(PointerEvent event) {
    if (_reindexType == ReindexType.move) {
      _reindexMove();
    } else if (_reindexType == ReindexType.reindexXY) {
      _reindexXYUp();
    } else if (_reindexType == ReindexType.reindexX) {
      _reindexXUp();
    } else if (_reindexType == ReindexType.reindexY) {
      _reindexYUp();
    }
  }

  void _reindexMove() {
    var x = _offset.dx;
    var y = _offset.dy;

    // 超过父容器左边
    if (_currentX < _parentLeft) {
      x = -(_startX - _parentLeft);
      // 超过父容器右边
    } else if (_currentX > (_parentRight - _width)) {
      x = (_parentRight - _width) - _startX;
    }

    // 超过父容器顶部
    if (_currentY < _parentTop) {
      y = -(_startY - _parentTop);
      // 超过父容器底部
    } else if (_currentY > (_parentBottom - _height)) {
      y = (_parentBottom - _height) - _startY;
    }

    _changeAnimation(Offset(x, y));
  }

  void _reindexXYUp() {
    _changeAnimation(Offset.zero);
  }

  void _reindexXUp() {
    var x = 0.0;
    var y = _offset.dy;

    // 当前view中心点靠近右边界
    if ((_currentX + (_width / 2)) >= (_parentWidth / 2)) {
      x = (_parentRight - _width) - _startX;

      // 当前view中心点靠近左边界
    } else {
      x = -(_startX - _parentLeft);
    }

    // 超过父容器顶部
    if (_currentY < _parentTop) {
      y = -(_startY - _parentTop);
      // 超过父容器底部
    } else if (_currentY > (_parentBottom - _height)) {
      y = (_parentBottom - _height) - _startY;
    }

    _changeAnimation(Offset(x, y));
  }

  void _reindexYUp() {
    var x = _offset.dx;
    var y = 0.0;

    // 超过父容器左边
    if (_currentX < _parentLeft) {
      x = -(_startX - _parentLeft);
      // 超过父容器右边
    } else if (_currentX > (_parentRight - _width)) {
      x = (_parentRight - _width) - _startX;
    }

    // 当前view中心点靠近下边界
    if ((_currentY + (_height / 2)) >= (_parentHeight / 2)) {
      y = (_parentBottom - _height) - _startY;

      // 当前view中心点靠近上边界
    } else {
      y = -(_startY - _parentTop);
    }

    _changeAnimation(Offset(x, y));
  }

  void _changeAnimation(Offset offset) {
    var animation = FractionalOffsetTween(
            begin: FractionalOffset(_offset.dx, _offset.dy),
            end: FractionalOffset(offset.dx, offset.dy))
        .animate(_animationController);

    animation.addListener(() => setState(() => _offset = Offset(
        animation.value?.dx ?? offset.dx, animation.value?.dy ?? offset.dy)));
    _animationController.reset();
    _animationController.forward();
  }
}
