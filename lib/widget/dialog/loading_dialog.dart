import 'package:flutter/material.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/7/25
/// @description
class LoadingDialog extends Dialog {
  final bool isCancel;

  const LoadingDialog({Key? key, this.isCancel = false}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      _LoadingDialogWidget(isCancel: isCancel);
}

class _LoadingDialogWidget extends StatefulWidget {
  final bool isCancel;

  const _LoadingDialogWidget({Key? key, this.isCancel = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<_LoadingDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
                child: Container(
                    width: 100,
                    height: 78,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(ThemeDimens.offsetRadiusMedium))),
                    child: const Center(child: CircularProgressIndicator())))),
        onWillPop: () async {
          return widget.isCancel;
        });
  }
}
