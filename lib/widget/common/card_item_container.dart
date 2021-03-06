import 'package:flutter/material.dart';
import 'package:playflutter/extensions/extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class CardItemContainer extends StatefulWidget {
  final Widget child;
  final double width;
  final double contentPadding;
  final Function? onItemClick;

  const CardItemContainer(
      {Key? key,
      required this.child,
      this.width = 0,
      this.contentPadding = ThemeDimens.offset_large,
      this.onItemClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardItemContainerState();
}

class _CardItemContainerState extends State<CardItemContainer> {
  @override
  Widget build(BuildContext context) {
    var content = Padding(
      padding: const EdgeInsets.all(ThemeDimens.offset_small),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(ThemeDimens.offset_radius_medium))),
        child: Material(
          child: InkWell(
            onTap: () => {widget.onItemClick.checkNullInvoke()},
            borderRadius:
                BorderRadius.circular(ThemeDimens.offset_radius_medium),
            child: Padding(
                padding: EdgeInsets.all(widget.contentPadding),
                child: widget.child),
          ),
        ),
      ),
    );
    if (widget.width == 0) {
      return content;
    } else {
      return SizedBox(
        width: widget.width,
        child: content,
      );
    }
  }
}
