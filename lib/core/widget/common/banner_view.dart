// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/9/15
/// @description 项目banner封装组件
class BannerView extends StatefulWidget {
  final int initialPage;
  final int itemCount;
  final IndexedWidgetBuilder indexedWidgetBuilder;
  final double? width;
  final double? height;
  final IndexedWidgetBuilder? indexedIndicatorBuilder;
  final BannerViewController? controller;
  final Function(int)? onIndexChange;
  final int timeMillis;
  final bool clipEnable;
  final bool loopEnable;

  const BannerView({
    Key? key,
    required this.initialPage,
    required this.itemCount,
    required this.indexedWidgetBuilder,
    this.width,
    this.height,
    this.indexedIndicatorBuilder,
    this.controller,
    this.onIndexChange,
    this.timeMillis = 3000,
    this.clipEnable = true,
    this.loopEnable = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BannerViewState();

  /// banner默认卡片样式item
  static Widget defaultBannerItem(String imagePath, {Function? onItemTap}) {
    return Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(ThemeDimens.offsetRadiusMedium))),
        child: Material(
            child: InkWell(
                onTap: () => onItemTap.checkNullInvoke(),
                borderRadius:
                    BorderRadius.circular(ThemeDimens.offsetRadiusMedium),
                child: CachedNetworkImage(
                    imageUrl: imagePath,
                    imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ThemeDimens.offsetRadiusMedium),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover))),
                    placeholder: (context, url) =>
                        Container(color: Theme.of(context).splashColor),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error)))));
  }

  /// banner默认圆点样式indicator
  static Widget defaultIndicator(int index, List<dynamic> data,
      {AlignmentGeometry alignment = Alignment.bottomCenter,
      EdgeInsetsGeometry? margin,
      Color activeColor = Colors.white,
      Color normalColor = Colors.grey}) {
    return Container(
        alignment: alignment,
        margin:
            margin ?? const EdgeInsets.only(bottom: ThemeDimens.offsetMedium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data
              .map((e) => Container(
                  margin: const EdgeInsets.all(ThemeDimens.offsetSmall),
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                      color:
                          data.indexOf(e) == index ? activeColor : normalColor,
                      shape: BoxShape.circle)))
              .toList(),
        ));
  }
}

class _BannerViewState extends State<BannerView> {
  final looperCountFactor = 500;
  var isStart = false;
  late final PageController pageController;
  late int currentPage;
  StreamSubscription? stream;

  @override
  void initState() {
    super.initState();
    widget.controller?.bindViewState(this);

    currentPage = widget.initialPage == 0
        ? getStartSelectItem(widget.itemCount)
        : widget.initialPage;
    pageController = PageController(
        initialPage: currentPage,
        viewportFraction: widget.clipEnable ? 0.85 : 1.0);

    startLoop();
  }

  @override
  void dispose() {
    stopLoop();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (event) => stopLoop(),
        onPointerUp: (event) => startLoop(),
        onPointerCancel: (event) => startLoop(),
        child: SizedBox(
          width: widget.width ?? double.infinity,
          height: widget.height ?? ThemeDimens.bannerHeight,
          child: Stack(
            children: [
              PageView.builder(
                  controller: pageController,
                  itemCount: getRealCount(),
                  dragStartBehavior: DragStartBehavior.down,
                  onPageChanged: (page) {
                    widget.onIndexChange?.run((self) => self(page));
                    setState(() => currentPage = page);
                  },
                  itemBuilder: (context, index) => widget.indexedWidgetBuilder(
                      context, getRealIndex(index, widget.itemCount))),
              widget.indexedIndicatorBuilder?.let((self) => self(
                      context, getRealIndex(currentPage, widget.itemCount))) ??
                  Container()
            ],
          ),
        ));
  }

  void startLoop() {
    // 是否符合自动轮播条件
    if (widget.itemCount > 0 && widget.loopEnable && isStart == false) {
      releaseAutoStream();
      isStart = true;
      stream = Stream.periodic(
              Duration(milliseconds: widget.timeMillis), (data) => data)
          .listen((value) => autoAnimatePage());
    }
  }

  void stopLoop() {
    isStart = false;
    releaseAutoStream();
  }

  void releaseAutoStream() {
    stream?.cancel();
    stream = null;
  }

  void autoAnimatePage() {
    if (currentPage == getRealCount() - 1) {
      pageController.jumpToPage(getStartSelectItem(widget.itemCount));
    } else {
      ++currentPage;
      pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void toPage(int page, bool isAnimation) {
    var tempPage = currentPage;
    while (getRealIndex(tempPage, widget.itemCount) != page) {
      tempPage++;
    }
    if (isAnimation) {
      pageController.jumpToPage(tempPage);
    } else {
      pageController.animateToPage(tempPage,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  int getRealIndex(int position, int size) => position % size;

  int getRealCount() => looperCountFactor * 3;

  int getStartSelectItem(int size) {
    // 我们设置当前选中的位置为Integer.MAX_VALUE / 2,这样开始就能往左滑动
    // 但是要保证这个值与getRealPosition 的 余数为0，因为要从第一页开始显示
    var currentItem = size * looperCountFactor ~/ 2;

    // 直到找到从0开始的位置
    while (getRealIndex(currentItem, size) != 0) {
      currentItem++;
    }
    return currentItem;
  }
}

/// banner控制器
class BannerViewController extends ChangeNotifier {
  late _BannerViewState _viewState;

  void bindViewState(_BannerViewState state) => _viewState = state;

  /// 开始轮播
  void startLoop() => _viewState.startLoop();

  /// 停止轮播
  void stopLoop() => _viewState.stopLoop();

  /// 无动画跳转
  void jumpToPage(page) => _viewState.toPage(page, false);

  /// 动画跳转
  void animateToPage(page) => _viewState.toPage(page, true);
}
