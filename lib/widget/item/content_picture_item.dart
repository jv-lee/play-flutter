import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/widget/common/card_item_container.dart';

/// @author jv.lee
/// @date 2022/6/24
/// @description 全局通用内容item
class ContentPictureItem extends StatefulWidget {
  final Content content;
  final Function(Content) onItemClick;

  const ContentPictureItem(
      {Key? key, required this.content, required this.onItemClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContentPictureItemState();
}

class _ContentPictureItemState extends State<ContentPictureItem> {
  @override
  Widget build(BuildContext context) {
    return CardItemContainer(
        contentPadding: 0,
        onItemClick: () => {widget.onItemClick(widget.content)},
        child: Row(children: [
          CachedNetworkImage(
              height: 146,
              width: 86,
              imageUrl: widget.content.envelopePic,
              imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                          left:
                              Radius.circular(ThemeDimens.offsetRadiusMedium)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover))),
              placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).splashColor,
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(
                                ThemeDimens.offsetRadiusMedium))),
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error)),
          Expanded(
              child: SizedBox(
                  height: 146,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: ThemeDimens.offsetMedium,
                                    left: ThemeDimens.offsetMedium,
                                    right: ThemeDimens.offsetMedium),
                                child: Text(
                                  widget.content.getTitle(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: ThemeDimens.fontSizeMedium,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ))),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: ThemeDimens.offsetMedium,
                                    left: ThemeDimens.offsetMedium,
                                    right: ThemeDimens.offsetMedium),
                                child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      widget.content.getDescription(),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: ThemeDimens.fontSizeSmall,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )))),
                        Container(
                            padding:
                                const EdgeInsets.all(ThemeDimens.offsetMedium),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.content.getCategory(),
                                      style: TextStyle(
                                          fontSize: ThemeDimens.fontSizeSmallX,
                                          color: Theme.of(context).focusColor)),
                                  Text(widget.content.getDateFormat(),
                                      style: TextStyle(
                                          fontSize: ThemeDimens.fontSizeSmallX,
                                          color: Theme.of(context)
                                              .primaryColorDark))
                                ]))
                      ])))
        ]));
  }
}
