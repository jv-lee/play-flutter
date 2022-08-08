import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/entity/parent_tab.dart';
import 'package:playflutter/view/system/system_content_list.dart';

/// @author jv.lee
/// @date 2022/7/26
/// @description 体系内容详情Tab页面
class SystemContentTabPage extends StatefulWidget {
  final ParentTab item;

  const SystemContentTabPage({Key? key, required this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SystemContentTabState();
}

class _SystemContentTabState
    extends BasePageState<SystemContentTabPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.item.children.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.item.name),
            bottom: TabBar(
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Theme.of(context).primaryColorLight,
                indicatorColor: Theme.of(context).primaryColorLight,
                tabs: widget.item.children
                    .map((e) => Tab(text: e.name))
                    .toList()),
          ),
          body: TabBarView(
              children: widget.item.children
                  .map((e) => SystemContentListPage(children: e))
                  .toList()),
        ));
  }
}
