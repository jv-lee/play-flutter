import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/widget/common/ink_well_container.dart';
import 'package:playflutter/core/widget/dialog/dialog_container.dart';

/// @author jv.lee
/// @date 2022/8/22
/// @description
class ConfirmDialog extends Dialog {
  final String titleText;
  final String? contentText;
  final String? cancelText;
  final String? confirmText;
  final bool singleConfirm;
  final Function? onCancel;
  final Function? onConfirm;

  const ConfirmDialog(
      {Key? key,
      required this.titleText,
      this.contentText,
      this.cancelText,
      this.confirmText,
      this.onConfirm,
      this.onCancel,
      this.singleConfirm = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) => DialogContainer(
        width: 240,
        height: contentText == null ? 100 : 120,
        stateBuild: (state, context) => Column(
          children: [
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(titleText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColorLight)),
                        Visibility(
                            visible: contentText != null,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: ThemeCommon.dimens.offsetMedium),
                                child: Text(contentText ?? "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryColorLight))))
                      ],
                    ))),
            Container(
                width: double.infinity,
                height: 1,
                color: Theme.of(context).primaryColor),
            SizedBox(
                width: double.infinity,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Visibility(
                        visible: !singleConfirm,
                        child: Expanded(
                            child: InkWellContainer(
                                onTap: () => onCancel.checkNullInvoke(),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        ThemeCommon.dimens.offsetRadiusMedium)),
                                child: Text(
                                    cancelText ?? ThemeCommon.strings.cancel,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryColorLight))))),
                    Visibility(
                        visible: !singleConfirm,
                        child: Container(
                          height: double.infinity,
                          width: 1,
                          color: Theme.of(context).primaryColor,
                        )),
                    Expanded(
                        child: InkWellContainer(
                            onTap: () => onConfirm.checkNullInvoke(),
                            borderRadius: singleConfirm
                                ? BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        ThemeCommon.dimens.offsetRadiusMedium),
                                    bottomRight: Radius.circular(
                                        ThemeCommon.dimens.offsetRadiusMedium))
                                : BorderRadius.only(
                                    bottomRight: Radius.circular(
                                        ThemeCommon.dimens.offsetRadiusMedium)),
                            child: Text(
                                confirmText ?? ThemeCommon.strings.confirm,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).primaryColorLight))))
                  ],
                ))
          ],
        ),
      );
}
