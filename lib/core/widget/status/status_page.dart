// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/widget/status/status.dart';

/// @author jv.lee
/// @date 2020/5/12
/// @description 状态控制页面容器
class StatusPage extends StatefulWidget {
  PageStatus status;
  final Widget child;
  final Widget? loading;
  final Widget? empty;
  final Widget? error;
  final Function? onPageReload;

  StatusPage(
      {Key? key,
      required this.status,
      required this.child,
      this.loading,
      this.empty,
      this.error,
      this.onPageReload})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) => buildWidget(context);

  Widget buildWidget(BuildContext context) {
    switch (widget.status) {
      case PageStatus.loading:
        return widget.loading ?? pageLoading(context);
      case PageStatus.empty:
        return widget.empty ?? pageEmpty(context);
      case PageStatus.error:
        return widget.error ??
            pageError(context, () {
              setState(() {
                widget.status = PageStatus.loading;
                widget.onPageReload.checkNullInvoke();
              });
            });
      case PageStatus.completed:
        return widget.child;
      default:
        return pageLoading(context);
    }
  }
}
