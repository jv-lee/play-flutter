import 'package:flutter/material.dart';
import 'package:playflutter/base/vm_state.dart';
import 'package:playflutter/view/search/viewmodel/search_viewmodel.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 搜索页
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends VMState<SearchPage,SearchViewModel> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("this is Search",
            style: TextStyle(color: Theme.of(context).primaryColorLight)),
      ),
    );
  }


}
