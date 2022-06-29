import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/entity/home_category.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description 首页分类item
class CategoryItem extends StatefulWidget {
  final HomeCategory category;
  final Function(HomeCategory)? onItemClick;

  const CategoryItem({Key? key, required this.category, this.onItemClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryItemState();
  }
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Padding(
        padding: const EdgeInsets.only(
            top: ThemeDimens.offset_medium,
            left: ThemeDimens.offset_medium,
            right: ThemeDimens.offset_medium),
        child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(ThemeDimens.offset_radius_medium))),
            color: Theme.of(context).cardColor,
            child: Material(
              child: InkWell(
                onTap: () => {
                  if (widget.onItemClick != null)
                    {widget.onItemClick!(widget.category)}
                },
                borderRadius:
                    BorderRadius.circular(ThemeDimens.offset_radius_medium),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: ThemeDimens.offset_medium,
                      bottom: ThemeDimens.offset_medium),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: SvgPicture.asset(widget.category.iconRes),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: ThemeDimens.offset_medium),
                        child: Text(
                          widget.category.name,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
