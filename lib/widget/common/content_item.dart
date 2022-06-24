import 'package:flutter/material.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/6/24
/// @description
class ContentItem extends StatefulWidget {
  final Content content;

  ContentItem({required this.content});

  @override
  State<StatefulWidget> createState() {
    return ContentItemState();
  }
}

class ContentItemState extends State<ContentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(ThemeDimens.offset_medium),
      padding: const EdgeInsets.all(ThemeDimens.offset_large),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(color: Theme.of(context).shadowColor)],
          borderRadius: const BorderRadius.all(
              Radius.circular(ThemeDimens.offset_radius_medium))),
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
      ),
    );
  }
}
