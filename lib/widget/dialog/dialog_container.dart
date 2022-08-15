import 'package:flutter/material.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description 通用dialog容器
class DialogContainer extends StatelessWidget {
  final double width;
  final double height;
  final bool isCancel;
  final Widget content;

  const DialogContainer(
      {Key? key,
      required this.width,
      required this.height,
      this.isCancel = false,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GestureDetector(
            onTap: () => isCancel ? Navigator.of(context).pop() : {},
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                    child: GestureDetector(
                        onTap: () => {},
                        child: Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        ThemeDimens.offsetRadiusMedium))),
                            child: content))))),
        onWillPop: () async => isCancel);
  }
}
