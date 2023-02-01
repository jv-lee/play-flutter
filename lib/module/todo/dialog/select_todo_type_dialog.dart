import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/module/todo/model/entity/todo_type.dart';
import 'package:playflutter/core/widget/common/overscroll_hide_container.dart';
import 'package:playflutter/core/widget/dialog/dialog_container.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description
class SelectTodoTypeDialog extends Dialog {
  final int startIndex;
  final ValueChanged<int> onSelectedItemChanged;
  final Function? onDismiss;

  const SelectTodoTypeDialog(
      {Key? key,
      required this.startIndex,
      required this.onSelectedItemChanged,
      this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
        width: 220,
        height: 120,
        onDismiss: onDismiss,
        // 可使用state.buildViewModel 创建vm作用域处理数据
        stateBuild: (state, context) => buildPicker(context),
        isCancel: true);
  }

  Widget buildPicker(BuildContext context) {
    return OverscrollHideContainer(
        scrollChild: CupertinoPicker(
            magnification: 1.25,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 32,
            scrollController:
                FixedExtentScrollController(initialItem: startIndex),
            onSelectedItemChanged: (index) => onSelectedItemChanged(index),
            selectionOverlay: Container(
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal:
                            BorderSide(color: Theme.of(context).hoverColor)),
                    color: Colors.transparent)),
            children: TodoTypeData.getTodoTypes()
                .map((e) => Center(
                    child: Text(e.name,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: ThemeCommon.dimens.fontSizeMedium))))
                .toList()));
  }
}
