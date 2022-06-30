/// @author jv.lee
/// @date 2022/6/30
/// @description
import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页体系tab 导航内容页面
class NavigationContentPage extends StatefulWidget {
  const NavigationContentPage({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationContentState();
}

class _NavigationContentState extends State<NavigationContentPage>
    with AutomaticKeepAliveClientMixin<NavigationContentPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text("this is NavigationContent",
                style: TextStyle(color: Theme.of(context).primaryColorLight)),
          ),
          Center(
            child: Text("this is NavigationContent",
                style: TextStyle(color: Theme.of(context).primaryColorLight)),
          )
        ],
      ),
    );
  }
}
