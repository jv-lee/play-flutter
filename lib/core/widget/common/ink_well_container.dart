import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/8/22
/// @description
class InkWellContainer extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final BorderRadius? borderRadius;

  const InkWellContainer(
      {Key? key, required this.child, required this.onTap, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
      borderRadius: borderRadius,
      child: InkWell(
          onTap: () => onTap(),
          borderRadius: borderRadius,
          child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: child)));
}
