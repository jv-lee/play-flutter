import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页我的tab
class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<StatefulWidget> createState() => _MeState();
}

class _MeState extends State<MePage>
    with AutomaticKeepAliveClientMixin<MePage> {
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
      body: Center(
        child: Text("this is Me",
            style: TextStyle(color: Theme.of(context).primaryColorLight)),
      ),
    );
  }
}
