import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel_state.dart';
import 'package:playflutter/view/search/viewmodel/search_result_viewmodel.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 搜索页
class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchResultState();
}

class _SearchResultState extends ViewModelState<SearchResultPage, SearchResultViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("this is Search Result",
            style: TextStyle(color: Theme.of(context).primaryColorLight)),
      ),
    );
  }
}
