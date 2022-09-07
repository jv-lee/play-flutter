import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:playflutter/core/tools/log_tools.dart';

/// 滑动到指定位置组件 (flutter_scroll_to_index库直接copy处理空安全,添加firstIndex回调接口)
class ScrollToIndexList extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final List<ScrollToIndexBaseObject> list;
  final Duration? duration;
  final double topDistance;
  final ScrollToIndexController controller;
  final ListVisibleItemCallback? callback;

  const ScrollToIndexList(
      {Key? key,
      required this.list,
      this.duration,
      this.topDistance = 0,
      required this.controller,
      required this.itemBuilder,
      this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScrollToIndexListState();
}

class _ScrollToIndexListState extends State<ScrollToIndexList> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _scrollKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _bindController();
  }

  // 绑定控制器
  void _bindController() {
    widget.controller._bind(this);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification: _onNotification,
        child: SingleChildScrollView(
          controller: _scrollController,
          key: _scrollKey,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: widget.itemBuilder,
            itemCount: widget.list.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ));
  }

  @override
  void didUpdateWidget(covariant ScrollToIndexList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _bindController();
    }
  }

  void scrollTo(int index, bool isAnimate) {
    if (index > widget.list.length) {
      return;
    }
    LogTools.log("ScrollToIndex", "scroll to index - $index");
    ScrollToIndexBaseObject item = widget.list[index];
    if (item.globalKey.currentContext != null) {
      RenderBox? renderBox =
          item.globalKey.currentContext?.findRenderObject() as RenderBox?;
      double dy = renderBox
              ?.localToGlobal(Offset.zero,
                  ancestor: _scrollKey.currentContext?.findRenderObject())
              .dy ??
          0;
      var offset = dy + _scrollController.offset;
      double stateTopHei = MediaQueryData.fromWindow(window).padding.top;
      double scrollOffset = offset - stateTopHei - widget.topDistance;

      // 限制滚动最大值
      if (scrollOffset >= _scrollController.position.maxScrollExtent) {
        scrollOffset = _scrollController.position.maxScrollExtent;
      }

      if (isAnimate) {
        _scrollController.animateTo(scrollOffset,
            duration: widget.duration ?? const Duration(milliseconds: 500),
            curve: Curves.linear);
      } else {
        _scrollController.jumpTo(scrollOffset);
      }
    } else {
      LogTools.log("ScrollToIndex",
          "Please bind the key to the widget in the outermost layer of the Item layout");
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _onNotification(ScrollNotification notice) {
    final SliverMultiBoxAdaptorElement sliverMultiBoxAdaptorElement =
        findSliverMultiBoxAdaptorElement(notice.context! as Element)!;

    final viewportDimension = notice.metrics.viewportDimension;

    int firstIndex = 0;
    int lastIndex = 0;
    void onVisitChildren(Element element) {
      final SliverMultiBoxAdaptorParentData oldParentData =
          element.renderObject?.parentData as SliverMultiBoxAdaptorParentData;
      double layoutOffset = oldParentData.layoutOffset!;
      double pixels = notice.metrics.pixels;
      double all = pixels + viewportDimension;
      if (layoutOffset >= pixels) {
        ///first和last是不同item
        firstIndex = min(firstIndex, oldParentData.index! - 1);
        if (layoutOffset <= all) {
          lastIndex = max(lastIndex, oldParentData.index!);
        }
        firstIndex = max(firstIndex, 0);
      } else {
        ///first和last是同一个item
        lastIndex = firstIndex = oldParentData.index!;
      }
    }

    sliverMultiBoxAdaptorElement.visitChildren(onVisitChildren);

    if (widget.callback != null) {
      widget.callback!(firstIndex, lastIndex);
    }

    return false;
  }

  SliverMultiBoxAdaptorElement? findSliverMultiBoxAdaptorElement(
      Element element) {
    if (element is SliverMultiBoxAdaptorElement) {
      return element;
    }
    SliverMultiBoxAdaptorElement? target;
    element.visitChildElements((child) {
      target = findSliverMultiBoxAdaptorElement(child);
    });
    return target;
  }
}

class ScrollToIndexController {
  _ScrollToIndexListState? _scrollToIndexState;

  /// 动画滑动到指定位置
  void animateTo(int index) {
    _scrollToIndexState?.scrollTo(index, true);
  }

  /// 直接跳到指定位置
  void jumpTo(int index) {
    _scrollToIndexState?.scrollTo(index, false);
  }

  void dispose() {
    _scrollToIndexState = null;
  }

  void _bind(_ScrollToIndexListState state) {
    _scrollToIndexState = state;
  }
}

/// 构建列表数据实体需要继承该base类提供globalKey查询渲染元素位置
class ScrollToIndexBaseObject {
  final GlobalKey globalKey = GlobalKey();
}

/// 列表view当前首个显示item下标及最后显示item下标回调callback
typedef ListVisibleItemCallback = void Function(int firstIndex, int lastIndex);
