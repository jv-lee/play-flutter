import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description
class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<StatefulWidget> createState() => _MeState();
}

class _MeState extends State<MePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Text("this is Me"),
      ),
    );
  }
}
