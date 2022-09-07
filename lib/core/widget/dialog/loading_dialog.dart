import 'package:flutter/material.dart';
import 'package:playflutter/core/widget/dialog/dialog_container.dart';

/// @author jv.lee
/// @date 2022/7/25
/// @description 通用loadingDialog
class LoadingDialog extends Dialog {
  final bool isCancel;

  const LoadingDialog({Key? key, this.isCancel = false}) : super(key: key);

  @override
  Widget build(BuildContext context) => DialogContainer(
      width: 100,
      height: 78,
      isCancel: isCancel,
      stateBuild: (state, context) => Center(
          child: CircularProgressIndicator(
              color: Theme.of(context).primaryColorLight)));
}
