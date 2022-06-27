import 'package:flutter/cupertino.dart';
import 'package:playflutter/tools/status_tools.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description
class AppHeaderContainer extends StatefulWidget {
  final Widget child;

  AppHeaderContainer({required this.child});

  @override
  State<StatefulWidget> createState() {
    return AppHeaderContainerState();
  }
}

class AppHeaderContainerState extends State<AppHeaderContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: StatusTools.getStatusHeight(),
        ),
        widget.child
      ],
    );
  }
}
