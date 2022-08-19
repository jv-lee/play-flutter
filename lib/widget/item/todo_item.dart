import 'package:flutter/material.dart';
import 'package:playflutter/model/entity/todo.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/widget/common/sliding_pane_container.dart';

/// @author jv.lee
/// @date 2022/8/19
/// @description
class TodoItem extends StatelessWidget {
  final Todo item;
  final SlidingPaneController controller;
  final TodoActionFunction onItemClick;
  final TodoActionFunction onItemDelete;
  final TodoActionFunction onItemUpdate;

  const TodoItem(
      {Key? key,
      required this.item,
      required this.controller,
      required this.onItemClick,
      required this.onItemDelete,
      required this.onItemUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingPaneContainer(
        width: double.infinity,
        height: ThemeDimens.todoItemHeight,
        controller: controller,
        slidingWidth: ThemeDimens.todoSlidingWidth,
        sliding: buildSliding(context),
        content: buildContent(context));
  }

  Widget buildSliding(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Material(
              child: InkWell(
                  onTap: () => onItemDelete(item),
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: const Text("删除",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ThemeDimens.fontSizeSmall)))))),
      Expanded(
          child: Material(
              child: InkWell(
                  onTap: () => onItemUpdate(item),
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: const Text("已读",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ThemeDimens.fontSizeSmall))))))
    ]);
  }

  Widget buildContent(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
                bottom:
                    BorderSide(width: 1, color: Theme.of(context).hoverColor))),
        child: Material(
            child: InkWell(
          onTap: () => onItemClick(item),
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ThemeDimens.offsetLarge,
                  vertical: ThemeDimens.offsetMedium),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title,
                        maxLines: 1,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: ThemeDimens.fontSizeMedium,
                            overflow: TextOverflow.ellipsis)),
                    Text(item.content,
                        maxLines: 1,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: ThemeDimens.fontSizeMedium,
                            overflow: TextOverflow.ellipsis))
                  ])),
        )));
  }
}

typedef TodoActionFunction = void Function(Todo);
