import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/9/30
/// @description
mixin FloatingContainerMixin<T extends StatefulWidget> on State<T> {
  bool firstBuild = true;
  ReIndexType reIndexType = ReIndexType.move;
  Offset _offset = const Offset(0, 0);
  Alignment _alignment = Alignment.center;
  EdgeInsets _margin = EdgeInsets.zero;

  double _startX = 0;
  double _startY = 0;
  double _currentX = 0;
  double _currentY = 0;

  double _parentLeft = 0;
  double _parentTop = 0;
  double _parentRight = 0;
  double _parentBottom = 0;

  double _width = 0;
  double _height = 0;
  double _maxWidth = 0;
  double _maxHeight = 0;

  double rectX() => _startX;

  double rectY() => _startY;

  double rectWidth() => _width;

  double rectHeight() => _height;

  double rectLeft() => _currentX;

  double rectTop() => _currentY;

  double rectRight() => _currentX + _width;

  double rectBottom() => _currentY + _height;

  Offset rectOffset() => _offset;

  void changePosition(BoxConstraints constraints, double width, double height,
      {AlignmentGeometry? alignment = Alignment.topLeft,
      EdgeInsetsGeometry? margin}) {
    if (firstBuild) {
      firstBuild = false;
    } else {
      return;
    }
    _width = width;
    _height = height;
    _maxWidth = constraints.maxWidth;
    _maxHeight = constraints.maxHeight;
    _alignment = alignment as Alignment? ?? Alignment.center;
    _margin = margin as EdgeInsets? ?? EdgeInsets.zero;

    _parentLeft = 0 + _margin.left;
    _parentTop = 0 + _margin.top;
    _parentRight = _maxWidth - _margin.right;
    _parentBottom = _maxHeight - _margin.bottom;

    if (alignment == Alignment.topLeft) {
      _startX = 0 + _margin.left;
      _startY = 0 + _margin.top;
    } else if (alignment == Alignment.topCenter) {
      _startX = (_maxWidth / 2) - (_width / 2);
      _startY = 0 + _margin.top;
    } else if (alignment == Alignment.topRight) {
      _startX = (_maxWidth - _width) - _margin.right;
      _startY = 0 + _margin.top;
    } else if (alignment == Alignment.centerLeft) {
      _startX = 0 + _margin.left;
      _startY = (_maxHeight / 2) - (_height / 2);
    } else if (alignment == Alignment.center) {
      _startX = ((_maxWidth / 2) - (_width / 2));
      _startY = (_maxHeight / 2) - (_height / 2);
    } else if (alignment == Alignment.centerRight) {
      _startX = (_maxWidth - width) - _margin.right;
      _startY = (_maxHeight / 2) - (_height / 2);
    } else if (alignment == Alignment.bottomLeft) {
      _startX = 0 + _margin.left;
      _startY = (_maxHeight - _height) - _margin.bottom;
    } else if (alignment == Alignment.bottomCenter) {
      _startX = ((_maxWidth / 2) - (_width / 2));
      _startY = (_maxHeight - _height) - _margin.bottom;
    } else if (alignment == Alignment.bottomRight) {
      _startX = (_maxWidth - width) - _margin.right;
      _startY = (_maxHeight - height) - _margin.bottom;
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
    // reindexXYUp();
    // reindexXUp();
    // reindexYUp();
    reindexMove();
  }

  void reindexMove() {
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

    setState(() {
      _offset = Offset(x, y);
    });
  }

  void reindexXYUp() {

  }

  void reindexXUp() {

  }

  void reindexYUp() {

  }

}

enum ReIndexType {
  // 不限制复位自由摆放
  move,
  // x，y轴同时开启复位
  reindexXY,
  // x轴开启复位
  reindexX,
  // y轴开启复位
  reindexY
}
