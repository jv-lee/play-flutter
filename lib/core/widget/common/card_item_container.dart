import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/theme/theme_common.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 卡片item容器
class CardItemContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double? contentPadding;
  final Function? onItemClick;

  const CardItemContainer(
      {Key? key,
      required this.child,
      this.width = 0,
      this.contentPadding,
      this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var content = Card(
        margin: EdgeInsets.all(ThemeCommon.dimens.offsetMedium),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(ThemeCommon.dimens.offsetRadiusMedium))),
        child: Material(
            child: InkWell(
                onTap: () => onItemClick.checkNullInvoke(),
                borderRadius: BorderRadius.circular(
                    ThemeCommon.dimens.offsetRadiusMedium),
                child: Container(
                    padding: EdgeInsets.all(
                        contentPadding ?? ThemeCommon.dimens.offsetLarge),
                    child: child))));
    return width == 0
        ? content
        : SizedBox(
            width: width,
            child: content,
          );
  }
}
