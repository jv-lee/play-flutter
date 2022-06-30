/// @author jv.lee 
/// @date 2022/6/30
/// @description 
import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页体系tab 体系内容页面
class SystemContentPage extends StatefulWidget {
  const SystemContentPage({super.key});

  @override
  State<StatefulWidget> createState() => _SystemContentState();
}

class _SystemContentState extends State<SystemContentPage>
    with AutomaticKeepAliveClientMixin<SystemContentPage> {
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
            child: Text("this is SystemContent",
                style: TextStyle(color: Theme.of(context).primaryColorLight)),
          ),
          Center(
            child: Text("this is SystemContent",
                style: TextStyle(color: Theme.of(context).primaryColorLight)),
          )
        ],
      ),
    );
  }
}
