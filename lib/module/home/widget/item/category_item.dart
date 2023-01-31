import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';
import 'package:playflutter/core/widget/common/card_item_container.dart';
import 'package:playflutter/module/home/model/entity/home_category.dart';
import 'package:playflutter/module/home/theme/theme_home.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description 首页分类item
class CategoryItem extends StatelessWidget {
  final HomeCategory category;
  final Function(HomeCategory)? onItemClick;

  const CategoryItem({Key? key, required this.category, this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItemContainer(
        width: MediaQuery.of(context).size.width / 2,
        onItemClick: () => onItemClick?.run((self) => self(category)),
        child: Column(children: [
          SizedBox(
              width: ThemeHome.dimens.categoryItemSize,
              height: ThemeHome.dimens.categoryItemSize,
              child: SvgPicture.asset(category.iconRes)),
          Container(
              padding: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
              child: Text(category.name,
                  style: TextStyle(color: Theme.of(context).primaryColorLight)))
        ]));
  }
}
