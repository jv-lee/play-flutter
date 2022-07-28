import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
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

class _SearchResultState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelCreator.create<SearchResultViewModel>(
        (context) => SearchResultViewModel(context),
        (context, viewModel) => Scaffold(
              appBar: AppBar(title: Text(widget.title)),
              body: buildSearchResultList(viewModel),
            ));
  }

  Widget buildSearchResultList(SearchResultViewModel viewModel) {
    return RefreshIndicator(
        color: Theme.of(context).primaryColorLight,
        onRefresh: () async {
          await Future<void>.delayed(const Duration(seconds: 1), () {
            viewModel.requestData(LoadStatus.refresh);
          });
        },
        child: SuperListView(
          statusController: viewModel.paging.statusController,
          itemCount: viewModel.paging.data.length,
          onPageReload: () {
            viewModel.requestData(LoadStatus.refresh);
          },
          onItemReload: () {
            viewModel.requestData(LoadStatus.reload);
          },
          onLoadMore: () {
            viewModel.requestData(LoadStatus.loadMore);
          },
          itemBuilder: (BuildContext context, int index) {
            Content item = viewModel.paging.data[index];
            itemClick(content) {
              Navigator.pushNamed(context, RouteNames.details,
                  arguments: item.transformDetails());
            }

            if (item.envelopePic.isEmpty) {
              return ContentItem(content: item, onItemClick: itemClick);
            } else {
              return ContentPictureItem(content: item, onItemClick: itemClick);
            }
          },
        ));
  }
}
