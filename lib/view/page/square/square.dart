import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description
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
    return const Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Text("this is Square"),
      ),
    );
  }
}
