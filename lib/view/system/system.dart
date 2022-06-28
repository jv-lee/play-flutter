import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页体系tab
class SystemPage extends StatefulWidget {
  const SystemPage({super.key});

  @override
  State<StatefulWidget> createState() => _SystemState();
}

class _SystemState extends State<SystemPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("this is System",
            style: TextStyle(color: Theme.of(context).primaryColorLight)),
      ),
    );
  }
}
