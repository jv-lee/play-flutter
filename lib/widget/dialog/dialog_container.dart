import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/extensions/common_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description 通用dialog容器
class DialogContainer extends StatefulWidget {
  final double width;
  final double height;
  final bool isCancel;
  final Function? onDismiss;
  final StateBuild stateBuild;

  const DialogContainer(
      {Key? key,
      required this.width,
      required this.height,
      this.isCancel = false,
      this.onDismiss,
      required this.stateBuild})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DialogContainerState();
}

class _DialogContainerState extends BasePageState<DialogContainer> {
  @override
  void dispose() {
    widget.onDismiss.checkNullInvoke();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      child: GestureDetector(
          onTap: () => widget.isCancel ? Navigator.of(context).pop() : {},
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                  child: GestureDetector(
                      onTap: () => {},
                      child: Container(
                          width: widget.width,
                          height: widget.height,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      ThemeDimens.offsetRadiusMedium))),
                          child: widget.stateBuild(this, context)))))),
      onWillPop: () async => widget.isCancel);
}
