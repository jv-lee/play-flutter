import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/view/home/model/entity/home_category.dart';
import 'package:playflutter/widget/common/card_item_container.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description 首页分类item
class CategoryItem extends StatefulWidget {
  final HomeCategory category;
  final Function(HomeCategory)? onItemClick;

  const CategoryItem({Key? key, required this.category, this.onItemClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return CardItemContainer(
        width: MediaQuery.of(context).size.width / 2,
        onItemClick: () => {
              if (widget.onItemClick != null)
                {widget.onItemClick!(widget.category)}
            },
        child: Column(children: [
          SizedBox(
              width: ThemeDimens.homeCategoryItemSize,
              height: ThemeDimens.homeCategoryItemSize,
              child: SvgPicture.asset(widget.category.iconRes)),
          Padding(
              padding: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
              child: Text(widget.category.name,
                  style: TextStyle(color: Theme.of(context).primaryColorLight)))
        ]));
  }
}
