import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/extensions/common_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/7/14
/// @description 设置item
class ProfileItem extends StatelessWidget {
  final String? leftSvgPath;
  final String? rightSvgPath;
  final String? leftText;
  final String? rightText;
  final bool switchVisible;
  final bool switchEnable;
  final bool switchChecked;
  final Function(bool)? onCheckedChange;
  final GestureTapCallback? onItemClick;

  const ProfileItem(
      {Key? key,
      this.leftSvgPath,
      this.rightSvgPath,
      this.leftText,
      this.rightText,
      this.switchVisible = false,
      this.switchEnable = true,
      this.switchChecked = false,
      this.onCheckedChange,
      this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lockSwitchColor = switchEnable
        ? null
        : MaterialStateColor.resolveWith((states) => Colors.grey);
    return Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).cardColor),
        child: Material(
            child: InkWell(
                onTap: onItemClick,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 22, top: 12, right: 22, bottom: 12),
                    child: Stack(alignment: Alignment.center, children: [
                      Row(children: [
                        leftSvgPath.hasVisible((object) => SizedBox(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(object.toString()))),
                        leftText.hasVisible((object) => Padding(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            child: Text(object.toString(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontSize: ThemeDimens.fontSizeMedium))))
                      ]),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        rightText.hasVisible((object) => Padding(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            child: Text(object.toString(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: ThemeDimens.fontSizeSmall)))),
                        switchVisible.isVisible(Switch(
                            trackColor: lockSwitchColor,
                            thumbColor: lockSwitchColor,
                            activeColor: Theme.of(context).focusColor,
                            activeTrackColor: Theme.of(context).hoverColor,
                            value: switchChecked,
                            onChanged: (enable) {
                              if (switchEnable && onCheckedChange != null) {
                                onCheckedChange!(enable);
                              }
                            })),
                        rightSvgPath.hasVisible((object) => SizedBox(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(object.toString())))
                      ])
                    ])))));
  }
}
