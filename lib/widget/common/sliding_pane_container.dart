import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/8/11
/// @description 侧滑菜单Container容器
class SlidingPaneContainer extends StatefulWidget {
  final double width;
  final double height;
  final double slidingWidth;
  final Alignment slidingAlign;
  final Widget sliding;
  final Widget content;
  final SlidingPaneController controller;

  static const double slidingDefaultWidth = 80;

  const SlidingPaneContainer(
      {Key? key,
      required this.width,
      required this.height,
      this.slidingWidth = slidingDefaultWidth,
      this.slidingAlign = Alignment.centerRight,
      required this.controller,
      required this.sliding,
      required this.content})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SlidingPaneContainerState();
}

class _SlidingPaneContainerState extends State<SlidingPaneContainer>
    with SingleTickerProviderStateMixin {
  Offset _offset = const Offset(0, 0);
  late AnimationController _animationController;
  late VoidCallback _callback;

  @override
  void initState() {
    super.initState();
    _callback = () => setState(() {});
    widget.controller.addListener(_callback);
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_callback);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(children: [
          Align(
              alignment: widget.slidingAlign,
              child: SizedBox(
                width: widget.slidingWidth,
                height: double.infinity,
                child: widget.sliding,
              )),
          buildDragContainer(SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: widget.content))
        ]));
  }

  Widget buildDragContainer(Widget child) {
    return Transform.translate(
        offset: _offset,
        child: GestureDetector(
          child: AbsorbPointer(
              absorbing: widget.controller.isExpand(), child: child),
          // 监听拖动距离实时更新offset 添加offset左右拖动限制值
          onHorizontalDragUpdate: (details) => _changeOffset(details.delta),
          // 监听拖动结束后进行复原展开处理
          onHorizontalDragEnd: (details) => _dragCancel(),
          // 监听按下时是否有展开未收起的item
          onHorizontalDragDown: (details) => _changeDownState(),
        ));
  }

  _changeOffset(Offset moveOffset) {
    setState(() {
      var endOffsetX = _offset.dx + moveOffset.dx;
      if (widget.slidingAlign == Alignment.centerLeft) {
        if (endOffsetX >= widget.slidingWidth) {
          _offset = Offset(widget.slidingWidth, 0);
        } else if (endOffsetX <= 0) {
          _offset = const Offset(0, 0);
        } else {
          _offset = _offset.translate(moveOffset.dx, moveOffset.dy);
        }
      } else {
        if (endOffsetX <= -widget.slidingWidth) {
          _offset = Offset(-widget.slidingWidth, 0);
        } else if (endOffsetX >= 0) {
          _offset = const Offset(0, 0);
        } else {
          _offset = _offset.translate(moveOffset.dx, moveOffset.dy);
        }
      }
    });
  }

  _closeAction() {
    widget.controller.updateExpand(false);
    var animator = IntTween(begin: _offset.dx.toInt(), end: 0)
        .animate(_animationController);
    animator.addListener(
        () => setState(() => _offset = Offset(animator.value.toDouble(), 0)));
    _animationController.reset();
    _animationController.forward();
  }

  _openAction() {
    var offsetX = widget.slidingAlign == Alignment.centerLeft
        ? widget.slidingWidth
        : -widget.slidingWidth;
    widget.controller.updateExpand(true);
    widget.controller.closeAction = _closeAction;

    var animator = IntTween(begin: _offset.dx.toInt(), end: offsetX.toInt())
        .animate(_animationController);
    animator.addListener(
        () => setState(() => _offset = Offset(animator.value.toDouble(), 0)));
    _animationController.reset();
    _animationController.forward();
  }

  _dragCancel() {
    if (_offset.dx.abs() > (widget.slidingWidth / 2)) {
      _openAction();
    } else {
      _closeAction();
    }
  }

  _changeDownState() {
    if (widget.controller.isExpand()) {
      widget.controller.updateExpand(false);
      widget.controller.closeAction();
    }
  }

  /// 提供给item中未被包含item点击的子widget，使用该方法构建需要显示的子item
  static Widget slidingPaneState(
      Widget widget, SlidingPaneController controller) {
    return GestureDetector(
        child: AbsorbPointer(absorbing: controller.isExpand(), child: widget),
        // 监听按下时是否有展开未收起的item
        onHorizontalDragDown: (details) {
          if (controller.isExpand()) {
            controller.updateExpand(false);
            controller.closeAction();
          }
        });
  }
}

/// SlidingPane控制器 控制所有item关闭
class SlidingPaneController extends ChangeNotifier {
  var _expand = false;
  Function closeAction = () {};

  isExpand() => _expand;

  updateExpand(expand) {
    _expand = expand;
    notifyListeners();
  }
}
