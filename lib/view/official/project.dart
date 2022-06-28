import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 项目tab列表
class OfficialPage extends StatefulWidget {
  const OfficialPage({super.key});

  @override
  State<StatefulWidget> createState() => _OfficialState();
}

class _OfficialState extends State<OfficialPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("this is Official",
            style: TextStyle(color: Theme.of(context).primaryColorLight)),
      ),
    );
  }
}
