import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/widget/common/overscroll_hide_container.dart';
import 'package:playflutter/widget/dialog/dialog_container.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description
class SelectTodoTypeDialog extends Dialog {
  const SelectTodoTypeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
        width: 220, height: 120, content: buildPicker(context), isCancel: true);
  }

  Widget buildPicker(BuildContext context) {
    return OverscrollHideContainer(
        scrollChild: CupertinoPicker(
            magnification: 1.25,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 32,
            onSelectedItemChanged: (index) {
              LogTools.log("TODO", "onSelectedItemChange:$index");
            },
            selectionOverlay: Container(
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal:
                            BorderSide(color: Theme.of(context).hoverColor)),
                    color: Colors.transparent)),
            children: _names
                .map((e) => Center(
                    child: Text(e,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: ThemeDimens.fontSizeMedium))))
                .toList()));
  }
}

const List<String> _names = <String>[
  '只用这一个',
  '工作',
  '生活',
  '娱乐',
];
