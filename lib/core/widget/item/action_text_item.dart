import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/data_format_extensions.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/widget/common/sliding_pane_container.dart';

/// @author jv.lee
/// @date 2022/8/5
/// @description 全局通用动作文本展示item 支持侧滑删除
class ActionTextItem extends StatelessWidget {
  final Content content;
  final SlidingPaneController slidingPaneController;
  final Function(Content) onItemClick;
  final Function(Content) onItemDelete;

  const ActionTextItem(
      {Key? key,
      required this.content,
      required this.slidingPaneController,
      required this.onItemClick,
      required this.onItemDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: ThemeCommon.dimens.offsetMedium),
        child: SlidingPaneContainer(
            width: double.infinity,
            height: 76,
            controller: slidingPaneController,
            sliding: buildItemMenu(context),
            content: buildItemContent(context)));
  }

  Widget buildItemMenu(BuildContext context) {
    return GestureDetector(
        onTap: () {
          slidingPaneController.closeAction();
          onItemDelete(content);
        },
        child: Container(
            width: SlidingPaneContainer.slidingDefaultWidth,
            height: double.infinity,
            color: Colors.red,
            child: Center(
                child: Text(ThemeCommon.strings.itemDelete,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ThemeCommon.dimens.fontSizeSmall)))));
  }

  Widget buildItemContent(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).cardColor,
        child: Material(
            child: InkWell(
                onTap: () => onItemClick(content),
                child: Padding(
                    padding: EdgeInsets.all(ThemeCommon.dimens.offsetLarge),
                    child: Stack(children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(content.getTitle(),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontSize: ThemeCommon.dimens.fontSizeSmall,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis))),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(content.getDateFormat(),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: ThemeCommon.dimens.fontSizeSmallX,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis)))
                    ])))));
  }
}
