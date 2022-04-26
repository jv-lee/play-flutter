import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Text("this is Main"),
      ),
    );
  }
}
