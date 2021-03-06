import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/extensions/extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/7/14
/// @description
class ProfileItem extends StatefulWidget {
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
      this.switchEnable = false,
      this.switchChecked = false,
      this.onCheckedChange,
      this.onItemClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Material(
        child: InkWell(
          onTap: widget.onItemClick,
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 22, top: 12, right: 22, bottom: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    children: [
                      widget.leftSvgPath.hasVisible(
                        (object) => SizedBox(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset(object.toString()),
                        ),
                      ),
                      widget.leftText.hasVisible((object) => Padding(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            child: Text(object.toString(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontSize: ThemeDimens.font_size_medium)),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      widget.rightText.hasVisible((object) => Padding(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            child: Text(object.toString(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: ThemeDimens.font_size_small)),
                          )),
                      widget.switchVisible.isVisible(Switch(
                          value: widget.switchChecked,
                          onChanged: widget.onCheckedChange)),
                      widget.rightSvgPath.hasVisible(
                        (object) => SizedBox(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset(object.toString()),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
