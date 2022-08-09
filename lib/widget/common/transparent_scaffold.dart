import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/8/9
/// @description
class TransparentScaffold extends StatelessWidget {
  final Color? color;
  final Widget child;

  const TransparentScaffold({Key? key, this.color, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: color ?? Theme.of(context).scaffoldBackgroundColor,
        ),
        body: child);
  }
}
