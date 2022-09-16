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
  final BannerViewController? controller;
  final Function(int)? onIndexTap;
  final Function(int)? onIndexChange;
  final int timeMillis;
  final bool clipEnable;
  final bool loopEnable;

  const BannerView({
    Key? key,
    required this.initialPage,
    required this.itemCount,
    required this.indexedWidgetBuilder,
    this.controller,
    this.onIndexTap,
    this.onIndexChange,
    this.timeMillis = 3000,
    this.clipEnable = true,
    this.loopEnable = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BannerViewState();

  static Widget cardBannerItem(String imagePath, {Function? onItemTap}) {
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
}

class _BannerViewState extends State<BannerView> {
  final looperCountFactor = 500;
  StreamSubscription? stream;
  var isStart = false;
  late final PageController pageController;
  late int itemPage;

  @override
  void initState() {
    super.initState();
    widget.controller?._startLoop = startLoop;
    widget.controller?._stopLoop = stopLoop;

    itemPage = widget.initialPage == 0
        ? getStartSelectItem(widget.itemCount, looperCountFactor)
        : widget.initialPage;
    pageController = PageController(
        initialPage: itemPage,
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
        onPointerDown: (event) => startLoop(),
        onPointerUp: (event) => startLoop(),
        onPointerCancel: (event) => startLoop(),
        child: PageView.builder(
            dragStartBehavior: DragStartBehavior.down,
            onPageChanged: (page) {
              widget.onIndexChange?.run((self) => self(page));
              itemPage = page;
            },
            controller: pageController,
            itemCount: looperCountFactor * 3,
            itemBuilder: (context, index) => widget.indexedWidgetBuilder(
                context, getRealIndex(index, widget.itemCount))));
  }

  void startLoop() {
    // 是否符合自动轮播条件
    if (widget.itemCount > 0 && widget.loopEnable && isStart == false) {
      isStart = true;
      stream = Stream.periodic(
              Duration(milliseconds: widget.timeMillis), (data) => data)
          .listen((value) => autoAnimatePage());
    }
  }

  void stopLoop() {
    isStart = false;
    stream?.cancel();
  }

  void autoAnimatePage() {
    if (itemPage == (looperCountFactor * 3) - 1) {
      pageController.jumpToPage(itemPage);
    } else {
      ++itemPage;
      pageController.animateToPage(itemPage,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  getRealIndex(int position, int size) => position % size;

  int getStartSelectItem(int size, int looperCount) {
    // 我们设置当前选中的位置为Integer.MAX_VALUE / 2,这样开始就能往左滑动
    // 但是要保证这个值与getRealPosition 的 余数为0，因为要从第一页开始显示
    var currentItem = size * looperCount ~/ 2;
    var realIndex = getRealIndex(currentItem, size);
    if (realIndex == 0) {
      return currentItem;
    }
    // 直到找到从0开始的位置
    while (realIndex != 0) {
      currentItem++;
    }
    return currentItem;
  }
}

class BannerViewController extends ChangeNotifier {
  Function _startLoop = () {};
  Function _stopLoop = () {};

  void startLoop() {
    _startLoop();
  }

  void stopLoop() {
    _stopLoop();
  }
}
