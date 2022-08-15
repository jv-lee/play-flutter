import 'package:flutter/material.dart';
import 'package:playflutter/extensions/common_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 卡片item容器
class CardItemContainer extends StatefulWidget {
  final Widget child;
  final double width;
  final double contentPadding;
  final Function? onItemClick;

  const CardItemContainer(
      {Key? key,
      required this.child,
      this.width = 0,
      this.contentPadding = ThemeDimens.offsetLarge,
      this.onItemClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardItemContainerState();
}

class _CardItemContainerState extends State<CardItemContainer> {
  @override
  Widget build(BuildContext context) {
    var content = Card(
        margin: const EdgeInsets.all(ThemeDimens.offsetMedium),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(ThemeDimens.offsetRadiusMedium))),
        child: Material(
            child: InkWell(
                onTap: () => {widget.onItemClick.checkNullInvoke()},
                borderRadius:
                    BorderRadius.circular(ThemeDimens.offsetRadiusMedium),
                child: Container(
                    padding: EdgeInsets.all(widget.contentPadding),
                    child: widget.child))));
    return widget.width == 0
        ? content
        : SizedBox(
            width: widget.width,
            child: content,
          );
  }
}
