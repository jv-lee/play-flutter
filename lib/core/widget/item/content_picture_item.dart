import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/data_format_extensions.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/widget/common/card_item_container.dart';

/// @author jv.lee
/// @date 2022/6/24
/// @description 全局通用内容item
class ContentPictureItem extends StatelessWidget {
  final Content content;
  final Function(Content) onItemClick;

  const ContentPictureItem(
      {Key? key, required this.content, required this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItemContainer(
        contentPadding: 0,
        onItemClick: () => {onItemClick(content)},
        child: Row(children: [
          CachedNetworkImage(
              height: 146,
              width: 86,
              imageUrl: content.envelopePic,
              imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(
                              ThemeCommon.dimens.offsetRadiusMedium)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover))),
              placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).splashColor,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(
                                ThemeCommon.dimens.offsetRadiusMedium))),
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
                                padding: EdgeInsets.only(
                                    top: ThemeCommon.dimens.offsetMedium,
                                    left: ThemeCommon.dimens.offsetMedium,
                                    right: ThemeCommon.dimens.offsetMedium),
                                child: Text(
                                  content.getTitle(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: ThemeCommon.dimens.fontSizeMedium,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ))),
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: ThemeCommon.dimens.offsetMedium,
                                    left: ThemeCommon.dimens.offsetMedium,
                                    right: ThemeCommon.dimens.offsetMedium),
                                child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      content.getDescription(),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize:
                                            ThemeCommon.dimens.fontSizeSmall,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )))),
                        Container(
                            padding:
                                EdgeInsets.all(ThemeCommon.dimens.offsetMedium),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(content.getCategory(),
                                      style: TextStyle(
                                          fontSize:
                                              ThemeCommon.dimens.fontSizeSmallX,
                                          color: Theme.of(context).focusColor)),
                                  Text(content.getDateFormat(),
                                      style: TextStyle(
                                          fontSize:
                                              ThemeCommon.dimens.fontSizeSmallX,
                                          color: Theme.of(context)
                                              .primaryColorDark))
                                ]))
                      ])))
        ]));
  }
}
