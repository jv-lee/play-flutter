import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/data_format_extensions.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/widget/common/card_item_container.dart';

/// @author jv.lee
/// @date 2022/6/24
/// @description 全局通用内容item
class ContentItem extends StatelessWidget {
  final Content content;
  final Function(Content) onItemClick;

  const ContentItem(
      {Key? key, required this.content, required this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItemContainer(
        onItemClick: () => onItemClick(content),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          SizedBox(
              width: double.infinity,
              child: Text(content.getAuthor(),
                  style: TextStyle(
                      fontSize: ThemeCommon.dimens.fontSizeMedium,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight))),
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: ThemeCommon.dimens.offsetMedium),
              width: double.infinity,
              child: Text(content.getTitle(),
                  style: TextStyle(
                      fontSize: ThemeCommon.dimens.fontSizeSmall,
                      color: Theme.of(context).primaryColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Padding(
                    padding:
                        EdgeInsets.only(right: ThemeCommon.dimens.offsetMedium),
                    child: Text(content.getCategory(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: ThemeCommon.dimens.fontSizeSmallX,
                            color: Theme.of(context).focusColor)))),
            Text(content.getDateFormat(),
                style: TextStyle(
                    fontSize: ThemeCommon.dimens.fontSizeSmallX,
                    color: Theme.of(context).primaryColorDark))
          ])
        ]));
  }
}
