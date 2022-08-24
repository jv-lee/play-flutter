import 'package:flutter/widgets.dart';

/// @author jv.lee
/// @date 2022/7/4
/// @description 禁止可滚动组件拓展水波纹效果
class OverscrollHideContainer extends StatelessWidget {
  final Widget scrollChild;

  const OverscrollHideContainer({Key? key, required this.scrollChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification? overscroll) {
          overscroll?.disallowIndicator();
          return true;
        },
        child: scrollChild);
  }
}
