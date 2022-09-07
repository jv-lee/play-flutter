import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/widget/status/status.dart';
import 'package:playflutter/core/widget/status/status_controller.dart';

/// @author jv.lee
/// @date 2020/5/13
/// @description 扩展ListView 可添加头部Widget/底部Widget - 页面加载装 loading/error/empty/data - item加载状态 loading/error/mepty/noMore
class SuperListView extends StatefulWidget {
  final ScrollController? scrollController;
  final StatusController statusController;
  final int itemCount;
  final Function? onPageReload;
  final Function? onItemReload;
  final Function? onLoadMore;
  final IndexedWidgetBuilder itemBuilder;
  final Widget? pageLoading;
  final Widget? pageEmpty;
  final Widget? pageError;
  final Widget? itemLoading;
  final Widget? itemError;
  final Widget? itemNoMore;
  final List<Widget> headerChildren;
  final List<Widget> footerChildren;
  final int itemMoreCount = 1;
  final bool isLoadMore;

  const SuperListView(
      {Key? key,
      required this.statusController,
      required this.itemCount,
      required this.itemBuilder,
      this.scrollController,
      this.onPageReload,
      this.onItemReload,
      this.onLoadMore,
      this.pageLoading,
      this.pageEmpty,
      this.pageError,
      this.itemLoading,
      this.itemError,
      this.itemNoMore,
      this.isLoadMore = false,
      this.headerChildren = const <Widget>[],
      this.footerChildren = const <Widget>[]})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuperListViewState();
}

class _SuperListViewState extends State<SuperListView> {
  late PageStatus _pageStatus;
  late ItemStatus _itemStatus;
  late ScrollController _controller;

  initScrollController() {
    _controller = widget.scrollController ?? ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (widget.statusController.itemStatus != ItemStatus.end &&
            widget.statusController.itemStatus != ItemStatus.error) {
          widget.onLoadMore.checkNullInvoke();
        }
      }
    });
  }

  changeStatus() {
    setState(() {
      _pageStatus = widget.statusController.pageStatus;
      _itemStatus = widget.statusController.itemStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageStatus = widget.statusController.pageStatus;
    _itemStatus = widget.statusController.itemStatus;
    widget.statusController.addListener(changeStatus);
    initScrollController();
  }

  @override
  void dispose() {
    widget.statusController.removeListener(changeStatus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildPageWidget(context);
  }

  Widget buildPageWidget(BuildContext context) {
    switch (_pageStatus) {
      case PageStatus.loading:
        return widget.pageLoading ?? pageLoading(context);
      case PageStatus.empty:
        return widget.pageEmpty ?? pageEmpty(context);
      case PageStatus.error:
        return widget.pageError ??
            pageError(context, () {
              widget.statusController.pageLoading().itemEmpty();
              widget.onPageReload.checkNullInvoke();
            });
      case PageStatus.completed:
        return buildPageData(context);
      default:
        return pageLoading(context);
    }
  }

  Widget buildPageData(BuildContext context) {
    // 屏蔽滚动水波纹效果
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification? overscroll) {
          overscroll?.disallowIndicator();
          return true;
        },
        child: ListView.builder(
            controller: _controller,
            padding: const EdgeInsets.all(0),
            itemCount: widget.itemCount +
                widget.headerChildren.length +
                widget.footerChildren.length +
                widget.itemMoreCount,
            itemBuilder: (BuildContext context, int index) {
              //创建headerItem
              if (index < widget.headerChildren.length) {
                return widget.headerChildren[index];
              }

              //创建contentItem
              if (index < (widget.headerChildren.length + widget.itemCount)) {
                return widget.itemBuilder(
                    context, index - widget.headerChildren.length);
              }

              //创建footerItem
              if (index <
                  (widget.headerChildren.length +
                      widget.itemCount +
                      widget.footerChildren.length)) {
                return widget.footerChildren[
                    index - (widget.headerChildren.length + widget.itemCount)];
              }

              return buildItemWidget(context);
            }));
  }

  Widget buildItemWidget(BuildContext context) {
    switch (_itemStatus) {
      case ItemStatus.loading:
        return itemLoading(context);
      case ItemStatus.empty:
        return itemEmpty(context);
      case ItemStatus.error:
        return itemError(context, () {
          widget.statusController.itemLoading();
          widget.onItemReload.checkNullInvoke();
        });
      case ItemStatus.end:
        return itemNoMore(context);
      default:
        return itemEmpty(context);
    }
  }
}
