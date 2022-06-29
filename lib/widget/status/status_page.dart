import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playflutter/extensions/extensions.dart';
import 'package:playflutter/widget/status/status.dart';

/// @author jv.lee
/// @date 2020/5/12
/// @description 状态控制页面容器
class StatusPage extends StatefulWidget {
  final PageStatus? status;
  final Widget? child;
  final Widget? loading;
  final Widget? empty;
  final Widget? error;
  final Function? reLoadFun;

  const StatusPage(
      {Key? key,
      this.status,
      this.child,
      this.loading,
      this.empty,
      this.error,
      this.reLoadFun})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StatusPageState();
  }
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }

  Widget buildWidget(BuildContext context) {
    switch (widget.status ?? PageStatus.loading) {
      case PageStatus.loading:
        return widget.loading ?? buildLoading(context);
      case PageStatus.empty:
        return widget.empty ?? buildEmpty(context);
      case PageStatus.error:
        return widget.error ?? buildError(context);
      case PageStatus.completed:
        return widget.child ?? buildData(context);
      default:
        return buildLoading(context);
    }
  }

  Widget buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildEmpty(BuildContext context) {
    return Center(
      child: Text("暂无数据",
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 16)),
    );
  }

  Widget buildError(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("加载失败",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 16)),
          CupertinoButton(
            child: const Text(
              "点击重试",
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              widget.reLoadFun.checkNullInvoke();
            },
          )
        ],
      ),
    );
  }

  Widget buildData(BuildContext context) {
    return Text('child == null',
        style: TextStyle(color: Theme.of(context).primaryColor));
  }
}
