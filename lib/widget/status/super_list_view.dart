import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playflutter/extensions/extensions.dart';
import 'package:playflutter/widget/status/status.dart';
import 'package:playflutter/widget/status/status_controller.dart';

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
      this.scrollController,
      required this.statusController,
      required this.itemCount,
      this.onPageReload,
      this.onItemReload,
      this.onLoadMore,
      required this.itemBuilder,
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
  State<StatefulWidget> createState() {
    return _SuperListViewState();
  }
}

class _SuperListViewState extends State<SuperListView> {
  late PageStatus _pageStatus;
  late ItemStatus _itemStatus;
  late ScrollController _controller;
  final double _itemHeight = 48.0;
  final double _fontSize = 16;

  initScrollController() {
    if (widget.scrollController != null) {
      _controller = widget.scrollController!;
    } else {
      _controller = ScrollController();
    }
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
    super.dispose();
    widget.statusController.removeListener(changeStatus);
  }

  @override
  Widget build(BuildContext context) {
    return buildPageWidget(context);
  }

  Widget buildPageWidget(BuildContext context) {
    switch (_pageStatus) {
      case PageStatus.loading:
        return widget.pageLoading ?? buildPageLoading(context);
      case PageStatus.empty:
        return widget.pageEmpty ?? buildPageEmpty(context);
      case PageStatus.error:
        return widget.pageError ?? buildPageError(context);
      case PageStatus.completed:
        return buildPageData(context);
      default:
        return buildPageLoading(context);
    }
  }

  Widget buildPageLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildPageEmpty(BuildContext context) {
    return Center(
      child: Text("暂无数据",
          style: TextStyle(
              color: Theme.of(context).primaryColor, fontSize: _fontSize)),
    );
  }

  Widget buildPageError(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("加载失败",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: _fontSize)),
          CupertinoButton(
            child: Text(
              "点击重试",
              style: TextStyle(fontSize: _fontSize),
            ),
            onPressed: () {
              widget.statusController.pageLoading().itemEmpty();
              widget.onPageReload.checkNullInvoke();
            },
          )
        ],
      ),
    );
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
        return buildItemLoading(context);
      case ItemStatus.empty:
        return buildItemEmpty(context);
      case ItemStatus.error:
        return buildItemError(context);
      case ItemStatus.end:
        return buildItemNoMore(context);
      default:
        return buildItemEmpty(context);
    }
  }

  Widget buildItemLoading(BuildContext context) {
    return Container(
      height: _itemHeight,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text("加载中...",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: _fontSize)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemEmpty(BuildContext context) {
    return Container(
      height: _itemHeight,
    );
  }

  Widget buildItemNoMore(BuildContext context) {
    return SizedBox(
      height: _itemHeight,
      child: Center(
        child: Text("没有更多了",
            style: TextStyle(
                color: Theme.of(context).primaryColor, fontSize: _fontSize)),
      ),
    );
  }

  Widget buildItemError(BuildContext context) {
    return SizedBox(
      height: _itemHeight,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "加载失败",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: _fontSize),
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "点击重试",
                  style: TextStyle(color: Colors.blue, fontSize: _fontSize),
                ),
              ),
              onTapDown: (details) {
                widget.statusController.itemLoading();
                widget.onItemReload.checkNullInvoke();
              },
            )
          ],
        ),
      ),
    );
  }
}
