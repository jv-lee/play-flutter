import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/extensions/data_format_extensions.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/core/widget/item/content_item.dart';
import 'package:playflutter/core/widget/item/content_picture_item.dart';
import 'package:playflutter/core/widget/status/super_list_view.dart';
import 'package:playflutter/module/details/details_route_names.dart';
import 'package:playflutter/module/search/viewmodel/search_result_viewmodel.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 搜索结果页
class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchResultState();
}

class _SearchResultState extends BasePageState<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<SearchResultViewModel>(
        create: (context) => SearchResultViewModel(context),
        viewBuild: (context, viewModel) => Scaffold(
            appBar: AppBar(title: Text(viewModel.viewStates.searchKey)),
            body: buildSearchResultList(viewModel)));
  }

  Widget buildSearchResultList(SearchResultViewModel viewModel) {
    return RefreshIndicator(
        color: Theme.of(context).primaryColorLight,
        onRefresh: () async {
          await Future<void>.delayed(const Duration(seconds: 1),
              () => viewModel.requestData(LoadStatus.refresh));
        },
        child: SuperListView(
            statusController: viewModel.viewStates.paging.statusController,
            itemCount: viewModel.viewStates.paging.data.length,
            onPageReload: () => viewModel.requestData(LoadStatus.refresh),
            onItemReload: () => viewModel.requestData(LoadStatus.reload),
            onLoadMore: () => viewModel.requestData(LoadStatus.loadMore),
            itemBuilder: (BuildContext context, int index) {
              Content item = viewModel.viewStates.paging.data[index];
              itemClick(content) {
                Navigator.pushNamed(context, DetailsRouteNames.details,
                    arguments: item.transformDetails());
              }

              if (item.envelopePic.isEmpty) {
                return ContentItem(content: item, onItemClick: itemClick);
              } else {
                return ContentPictureItem(
                    content: item, onItemClick: itemClick);
              }
            }));
  }
}
