import 'package:flutter/material.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/widget/common/card_item_container.dart';

/// @author jv.lee
/// @date 2022/8/5
/// @description 全局通用动作文本展示item 支持侧滑删除
class ActionTextItem extends StatefulWidget {
  final Content content;
  final Function(Content) onItemClick;

  const ActionTextItem(
      {Key? key, required this.content, required this.onItemClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ActionTextItemState();
  }
}

class _ActionTextItemState extends State<ActionTextItem> {
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
                      fontSize: ThemeDimens.fontSizeMedium,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight),
                )),
            Padding(
              padding: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
              child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.content.getTitle(),
                    style: TextStyle(
                        fontSize: ThemeDimens.fontSizeSmall,
                        color: Theme.of(context).primaryColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.content.getCategory(),
                    style: TextStyle(
                        fontSize: ThemeDimens.fontSizeSmallX,
                        color: Theme.of(context).focusColor),
                  ),
                  Text(
                    widget.content.getDateFormat(),
                    style: TextStyle(
                        fontSize: ThemeDimens.fontSizeSmallX,
                        color: Theme.of(context).primaryColorDark),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
