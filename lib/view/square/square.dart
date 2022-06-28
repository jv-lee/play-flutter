import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页广场tab
class SquarePage extends StatefulWidget {
  const SquarePage({super.key});

  @override
  State<StatefulWidget> createState() => _SquareState();
}

class _SquareState extends State<SquarePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("this is Square",
            style: TextStyle(color: Theme.of(context).primaryColorLight)),
      ),
    );
  }
}
