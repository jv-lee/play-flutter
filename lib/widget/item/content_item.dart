import 'package:flutter/material.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/widget/common/card_item_container.dart';

/// @author jv.lee
/// @date 2022/6/24
/// @description 全局通用内容item
class ContentItem extends StatefulWidget {
  final Content content;
  final Function(Content) onItemClick;

  const ContentItem(
      {Key? key, required this.content, required this.onItemClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ContentItemState();
  }
}

class _ContentItemState extends State<ContentItem> {
  @override
  Widget build(BuildContext context) {
    return CardItemContainer(
        onItemClick: () => {widget.onItemClick(widget.content)},
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
                width: double.infinity,
                child: Text(
                  widget.content.getAuthor(),
                  style: TextStyle(
                      fontSize: ThemeDimens.font_size_medium,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight),
                )),
            Padding(
              padding: const EdgeInsets.only(top: ThemeDimens.offset_medium),
              child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.content.getTitle(),
                    style: TextStyle(
                        fontSize: ThemeDimens.font_size_small,
                        color: Theme.of(context).primaryColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: ThemeDimens.offset_medium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.content.getCategory(),
                    style: TextStyle(
                        fontSize: ThemeDimens.font_size_small_x,
                        color: Theme.of(context).focusColor),
                  ),
                  Text(
                    widget.content.getDateFormat(),
                    style: TextStyle(
                        fontSize: ThemeDimens.font_size_small_x,
                        color: Theme.of(context).primaryColorDark),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
