import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/9/30
/// @description
mixin FloatingContainerMixin<T extends StatefulWidget> on State<T> {
  ReIndexType reIndexType = ReIndexType.move;
  Offset _offset = const Offset(0, 0);

  double _x = 0;
  double _y = 0;

  double _width = 0;
  double _height = 0;
  double _maxWidth = 0;
  double _maxHeight = 0;

  double rectX() => _x;

  double rectY() => _y;

  double rectWidth() => _width;

  double rectHeight() => _height;

  double rectLeft() => _x;

  double rectTop() => _y;

  double rectRight() => _x + _width;

  double rectBottom() => _y + _height;

  Offset rectOffset() => _offset;

  void changePosition(BoxConstraints constraints, double width, double height,
      {AlignmentGeometry? alignment = Alignment.topLeft,
      EdgeInsetsGeometry? margin}) {
    _width = width;
    _height = height;
    _maxWidth = constraints.maxWidth;
    _maxHeight = constraints.maxHeight;

    if (alignment == Alignment.topLeft) {
      _x = 0;
      _y = 0;
    } else if (alignment == Alignment.topCenter) {
      _x = (_maxWidth / 2) - (_width / 2);
      _y = 0;
    } else if (alignment == Alignment.topRight) {
      _x = _maxWidth - _width;
      _y = 0;
    } else if (alignment == Alignment.centerLeft) {
      _x = 0;
      _y = (_maxHeight / 2) - (_height / 2);
    } else if (alignment == Alignment.center) {
      _x = ((_maxWidth / 2) - (_width / 2));
      _y = (_maxHeight / 2) - (_height / 2);
    } else if (alignment == Alignment.centerRight) {
      _x = _maxWidth - width;
      _y = (_maxHeight / 2) - (_height / 2);
    } else if (alignment == Alignment.bottomLeft) {
      _x = 0;
      _y = _maxHeight - _height;
    } else if (alignment == Alignment.bottomCenter) {
      _x = ((_maxWidth / 2) - (_width / 2));
      _y = _maxHeight - _height;
    } else if (alignment == Alignment.bottomRight) {
      _x = _maxWidth - width;
      _y = _maxHeight - height;
    }

    if (margin != null && margin is EdgeInsets) {
      _x += margin.left;
      _x -= margin.right;
      _y += margin.top;
      _y -= margin.bottom;
    }
  }

  void changeOffset(PointerEvent event) {
    setState(() {
      _offset =
          Offset(_offset.dx + event.delta.dx, _offset.dy + event.delta.dy);

      _x += _offset.dx;
      _y += _offset.dy;
    });
  }

  void changeUp(PointerEvent event) {

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
