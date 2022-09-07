import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 卡片item容器
class CardItemContainer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    var content = Card(
        margin: const EdgeInsets.all(ThemeDimens.offsetMedium),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(ThemeDimens.offsetRadiusMedium))),
        child: Material(
            child: InkWell(
                onTap: () => onItemClick.checkNullInvoke(),
                borderRadius:
                    BorderRadius.circular(ThemeDimens.offsetRadiusMedium),
                child: Container(
                    padding: EdgeInsets.all(contentPadding), child: child))));
    return width == 0
        ? content
        : SizedBox(
            width: width,
            child: content,
          );
  }
}
