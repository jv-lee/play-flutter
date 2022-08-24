import 'package:flutter/material.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/widget/common/card_item_container.dart';

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
                      fontSize: ThemeDimens.fontSizeMedium,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight))),
          Container(
              padding: const EdgeInsets.symmetric(
                  vertical: ThemeDimens.offsetMedium),
              width: double.infinity,
              child: Text(content.getTitle(),
                  style: TextStyle(
                      fontSize: ThemeDimens.fontSizeSmall,
                      color: Theme.of(context).primaryColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Padding(
                    padding:
                    const EdgeInsets.only(right: ThemeDimens.offsetMedium),
                    child: Text(content.getCategory(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: ThemeDimens.fontSizeSmallX,
                            color: Theme.of(context).focusColor)))),
            Text(content.getDateFormat(),
                style: TextStyle(
                    fontSize: ThemeDimens.fontSizeSmallX,
                    color: Theme.of(context).primaryColorDark))
          ])
        ]));
  }
}
