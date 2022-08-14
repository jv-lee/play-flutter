import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/8/2
/// @description 项目banner封装组件
class AppBanner extends StatefulWidget {
  final int index;
  final int count;
  final ValueChanged<int> onIndexChanged;
  final Function(int) onIndexTap;
  final FindPath findPath;
  final SwiperController? controller;

  const AppBanner(
      {Key? key,
      this.controller,
      required this.index,
      required this.count,
      required this.onIndexChanged,
      required this.onIndexTap,
      required this.findPath})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppBannerState();
}

class _AppBannerState extends State<AppBanner> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: ThemeDimens.homeBannerHeight,
        child: Swiper(
            controller: widget.controller,
            index: widget.index,
            viewportFraction: 0.85,
            autoplay: true,
            duration: 300,
            itemCount: widget.count,
            onIndexChanged: widget.onIndexChanged,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ThemeDimens.offsetRadiusMedium)),
                  child: Material(
                      child: InkWell(
                          onTap: () => widget.onIndexTap(index),
                          borderRadius: BorderRadius.circular(
                              ThemeDimens.offsetRadiusMedium),
                          child: CachedNetworkImage(
                              imageUrl: widget.findPath(index),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              ThemeDimens.offsetRadiusMedium),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover))),
                              placeholder: (context, url) => Container(
                                  color: Theme.of(context).splashColor),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error)))));
            },
            pagination: const SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    activeSize: 6,
                    size: 6,
                    color: Colors.grey,
                    activeColor: Colors.white))));
  }
}

typedef FindPath = String Function(int);
