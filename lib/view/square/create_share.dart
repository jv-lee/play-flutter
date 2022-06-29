import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 创建分享内容页
class CreateSharePage extends StatefulWidget {
  const CreateSharePage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateShareState();
}

class _CreateShareState extends State<CreateSharePage>
    with AutomaticKeepAliveClientMixin<CreateSharePage> {
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
        child: Text("this is createShare",
            style: TextStyle(color: Theme.of(context).primaryColorLight)),
      ),
    );
  }
}
