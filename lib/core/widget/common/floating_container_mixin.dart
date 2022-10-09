import 'package:flutter/material.dart';
import 'package:playflutter/core/tools/log_tools.dart';

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

    if (alignment == Alignment.topLeft) {
      _startX = 0;
      _startY = 0;
    } else if (alignment == Alignment.topCenter) {
      _startX = (_maxWidth / 2) - (_width / 2);
      _startY = 0;
    } else if (alignment == Alignment.topRight) {
      _startX = _maxWidth - _width;
      _startY = 0;
    } else if (alignment == Alignment.centerLeft) {
      _startX = 0;
      _startY = (_maxHeight / 2) - (_height / 2);
    } else if (alignment == Alignment.center) {
      _startX = ((_maxWidth / 2) - (_width / 2));
      _startY = (_maxHeight / 2) - (_height / 2);
    } else if (alignment == Alignment.centerRight) {
      _startX = _maxWidth - width;
      _startY = (_maxHeight / 2) - (_height / 2);
    } else if (alignment == Alignment.bottomLeft) {
      _startX = 0;
      _startY = _maxHeight - _height;
    } else if (alignment == Alignment.bottomCenter) {
      _startX = ((_maxWidth / 2) - (_width / 2));
      _startY = _maxHeight - _height;
    } else if (alignment == Alignment.bottomRight) {
      _startX = _maxWidth - width;
      _startY = _maxHeight - height;
    }

    LogTools.log("jv-lee", "INIT margin:$_startX,${_margin.left}");
  }

  void changeOffset(PointerEvent event) {
    setState(() {
      _offset =
          Offset(_offset.dx + event.delta.dx, _offset.dy + event.delta.dy);

      _currentX = _startX + _offset.dx;
      _currentY = _startY + _offset.dy;
      LogTools.log("JV-LEE", "currentX:$_currentX");
    });
  }

  void changeUp(PointerEvent event) {
    // moveUp();
    // reindexXYUp();
    // reindexXUp();
    // reindexYUp();
    reindexMove();
  }

  void reindexMove() {
    var x = _currentX;
    var y = _currentY;

    if (_alignment == Alignment.topLeft) {
      if (_currentX < 0) {
        x = 0;
      } else if (_currentX >
          (_maxWidth - _width) - (_margin.right + _margin.left)) {
        x = (_maxWidth - _width) - (_margin.right + _margin.left);
      }

      if (_currentY < 0) {
        y = 0;
      } else if (_currentY >
          (_maxHeight - _height) - (_margin.top + _margin.bottom)) {
        y = (_maxHeight - _height) - (_margin.top + _margin.bottom);
      }
    }

    if (_alignment == Alignment.topCenter) {
      if (_currentX < -(((_maxWidth / 2) - (_width / 2))) - _margin.left) {
        x = -(((_maxWidth / 2) - (_width / 2)) - _margin.left);
      }

      if (_currentY < 0) {
        y = 0;
      } else if (_currentY >
          (_maxHeight - _height) - (_margin.top + _margin.bottom)) {
        y = (_maxHeight - _height) - (_margin.top + _margin.bottom);
      }
    }

    setState(() {
      _offset = Offset(x, y);
    });
  }

  void moveUp() {
    _resetBoundLimitHorizontal();
    _resetBoundLimitVertical();

    setState(() {
      _offset = Offset(_currentX, _currentY);
    });
  }

  void reindexXYUp() {
    setState(() {
      _offset = Offset.zero;
    });
  }

  void reindexXUp() {
    _resetBoundLimitVertical();
    if (_resetBoundLimitHorizontal()) {
      setState(() {
        _offset = Offset(_currentX, _currentY);
      });
    } else if ((_currentX + (_width / 2)) > (_maxWidth / 2)) {
      // setState(() {
      //   _offset = Offset(0, _currentY);
      // });
    } else {}

    if ((_currentX + (_width / 2)) > (_maxWidth / 2)) {
      // setState(() {
      //   _offset = Offset(0, _currentY);
      // });
    }
  }

  void reindexYUp() {
    _resetBoundLimitHorizontal();
    _resetBoundLimitVertical();

    setState(() {
      _offset = Offset(_currentX, 0);
    });
  }

  bool _resetBoundLimitHorizontal() {
    if (rectLeft() < 0) {
      _currentX = 0;
      return true;
    }
    if (rectRight() > _maxWidth) {
      _currentX = _maxWidth - _width;
      return true;
    }

    return false;
  }

  bool _resetBoundLimitVertical() {
    if (rectTop() < 0) {
      _currentY = 0;
      return true;
    }
    if (rectBottom() > _maxHeight) {
      _currentY = _maxHeight - _height;
      return true;
    }

    return false;
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
