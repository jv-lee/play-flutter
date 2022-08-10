import 'package:flutter/material.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';

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
    return Padding(
        padding: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
        child: Container(
            width: double.infinity,
            height: 76,
            color: Theme.of(context).cardColor,
            child: Material(
                child: InkWell(
                    onTap: () => widget.onItemClick(widget.content),
                    child: Padding(
                        padding: const EdgeInsets.all(ThemeDimens.offsetLarge),
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  widget.content.getTitle(),
                                  maxLines: 1,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontSize: ThemeDimens.fontSizeSmall,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                )),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(widget.content.getDateFormat(),
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: ThemeDimens.fontSizeSmallX,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis)))
                          ],
                        ))))));
  }
}
