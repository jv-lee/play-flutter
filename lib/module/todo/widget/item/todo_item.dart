import 'package:flutter/material.dart';
import 'package:playflutter/core/model/entity/todo.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';
import 'package:playflutter/core/tools/localizations.dart';
import 'package:playflutter/core/widget/common/sliding_pane_container.dart';
import 'package:playflutter/module/todo/model/entity/todo_type.dart';

/// @author jv.lee
/// @date 2022/8/19
/// @description 日记模块列表item
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
        content: buildContent(context),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Theme.of(context).hoverColor))));
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
                      child: Text("item_delete".localized(),
                          style: const TextStyle(
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
                      child: Text(
                          item.status == TodoStatus.UPCOMING.index
                              ? "todo_item_complete".localized()
                              : "todo_item_upcoming".localized(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: ThemeDimens.fontSizeSmall))))))
    ]);
  }

  Widget buildContent(BuildContext context) {
    return Stack(children: [
      Container(
          width: double.infinity,
          height: double.infinity,
          color: Theme.of(context).cardColor,
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
          ))),
      Visibility(
          visible: item.priority == TodoPriority.HIGH.index,
          child: buildItemSubscript())
    ]);
  }

  /// 绘制重要todoItem角标
  Widget buildItemSubscript() {
    return Stack(children: [
      CustomPaint(
          foregroundPainter: SubscriptPainter(),
          child: const SizedBox(width: 25, height: 32)),
      Transform(
          transform:
              Transform.translate(offset: const Offset(-2, 14)).transform,
          child: Container(
              width: 25,
              height: 25,
              transform: Transform.rotate(angle: -45).transform,
              child: Text("todo_create_level_high".localized(),
                  style: const TextStyle(fontSize: 8, color: Colors.white))))
    ]);
  }
}

class SubscriptPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    var path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

typedef TodoActionFunction = void Function(Todo);
