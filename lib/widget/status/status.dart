import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playflutter/widget/common/delay_visibility.dart';

/// @author jv.lee
/// @date 2020/5/12
/// @description 分页加载状态枚举类 及 通用page/item widget

enum PageStatus { loading, empty, completed, error }

enum ItemStatus { loading, empty, end, error }

const double _itemHeight = 48.0;

Widget pageLoading(BuildContext context) {
  return const DelayVisibility(
      child: Center(child: CircularProgressIndicator()));
}

Widget pageEmpty(BuildContext context) {
  return Center(
      child: Text("暂无数据",
          style: TextStyle(color: Theme.of(context).primaryColorLight)));
}

Widget pageError(BuildContext context, Function reload) {
  return Center(
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
    Text("加载失败", style: TextStyle(color: Theme.of(context).primaryColorLight)),
    CupertinoButton(
        child: const Text("点击重试", style: TextStyle(color: Colors.blue)),
        onPressed: () => reload())
  ]));
}

Widget itemEmpty(BuildContext context) {
  return Container(height: _itemHeight);
}

Widget itemLoading(BuildContext context) {
  return SizedBox(
      height: _itemHeight,
      child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(strokeWidth: 2)),
            Container(
                padding: const EdgeInsets.only(left: 10),
                child: Text("加载中...",
                    style:
                        TextStyle(color: Theme.of(context).primaryColorLight)))
          ])));
}

Widget itemNoMore(BuildContext context) {
  return SizedBox(
      height: _itemHeight,
      child: Center(
          child: Text("没有更多了",
              style: TextStyle(color: Theme.of(context).primaryColorLight))));
}

Widget itemError(BuildContext context, Function reload) {
  return SizedBox(
      height: _itemHeight,
      child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text("加载失败",
                style: TextStyle(color: Theme.of(context).primaryColorLight)),
            GestureDetector(
                child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text("点击重试",
                        style: TextStyle(color: Colors.blue))),
                onTap: () => reload())
          ])));
}
