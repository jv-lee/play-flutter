import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel_state.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/search/viewmodel/search_result_viewmodel.dart';
import 'package:playflutter/widget/item/content_item.dart';
import 'package:playflutter/widget/item/content_picture_item.dart';
import 'package:playflutter/widget/status/super_list_view.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 搜索结果页
class SearchResultPage extends StatefulWidget {
  final String title;

  const SearchResultPage({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _SearchResultState();
}

class _SearchResultState
    extends ViewModelState<SearchResultPage, SearchResultViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: buildSearchResultList(),
    );
  }

  Widget buildSearchResultList() {
    return RefreshIndicator(
        color: Theme.of(context).primaryColorLight,
        onRefresh: () async {
          await Future<void>.delayed(const Duration(seconds: 1), () {
            readVM().requestData(LoadStatus.refresh);
          });
        },
        child: SuperListView(
          statusController: providerOfVM().paging.statusController,
          itemCount: providerOfVM().paging.data.length,
          onPageReload: () {
            readVM().requestData(LoadStatus.refresh);
          },
          onItemReload: () {
            readVM().requestData(LoadStatus.reload);
          },
          onLoadMore: () {
            readVM().requestData(LoadStatus.loadMore);
          },
          itemBuilder: (BuildContext context, int index) {
            var item = providerOfVM().paging.data[index];
            itemClick(item) => {
                  Navigator.pushNamed(context, RouteNames.details,
                      arguments: item.transformDetails())
                };
            if (item.envelopePic.isEmpty) {
              return ContentItem(content: item, onItemClick: itemClick);
            } else {
              return ContentPictureItem(content: item, onItemClick: itemClick);
            }
          },
        ));
  }
}
