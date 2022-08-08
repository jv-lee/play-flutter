// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:playflutter/base/page_state.dart';
import 'package:playflutter/db/entity/search_history.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/search/model/entity/search_hot.dart';
import 'package:playflutter/view/search/viewmodel/search_viewmodel.dart';
import 'package:playflutter/widget/common/overscroll_hide_container.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 搜索页
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchState();

  static const String ARG_SEARCH_KEY = "searchKey";
}

class _SearchState extends PageState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<SearchViewModel>(
        create: (context) => SearchViewModel(context),
        viewBuild: (context, viewModel) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            // 全页面点击隐藏软键盘
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              // 设置该属性使软键盘弹起时直接遮盖页面view
              resizeToAvoidBottomInset: false,
              appBar: buildSearchAppBar(viewModel),
              body: buildSearchContent(viewModel),
            )));
  }

  PreferredSizeWidget buildSearchAppBar(SearchViewModel viewModel) {
    return AppBar(
        title: TextField(
            onSubmitted: (text) => {viewModel.navigationSearchKey(text)},
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
                hintText: ThemeStrings.search_hint_text)));
  }

  Widget buildSearchContent(SearchViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [buildSearchHot(viewModel), buildSearchHistory(viewModel)],
      ),
    );
  }

  Widget buildSearchHot(SearchViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buildSearchHotLabel(viewModel), buildSearchHotFlow(viewModel)],
    );
  }

  Widget buildSearchHotLabel(SearchViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(ThemeDimens.offset_large),
      child: Text(
        ThemeStrings.search_hot_label,
        style: TextStyle(
            color: Theme.of(context).primaryColorLight,
            fontSize: ThemeDimens.font_size_medium),
      ),
    );
  }

  Widget buildSearchHotFlow(SearchViewModel viewModel) {
    var widgets = viewModel.searchHots
        .map((e) => buildSearchHotFlowItem(viewModel, e))
        .toList();

    return Padding(
      padding: const EdgeInsets.only(
          left: ThemeDimens.offset_large, right: ThemeDimens.offset_large),
      child: Wrap(spacing: -4, runSpacing: -2, children: widgets),
    );
  }

  Widget buildSearchHotFlowItem(
      SearchViewModel viewModel, SearchHot searchHot) {
    return Card(
      elevation: 0,
      color: Theme.of(context).hintColor,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(ThemeDimens.offset_radius_medium)),
      child: InkWell(
        onTap: () => {viewModel.navigationSearchKey(searchHot.hotKey)},
        borderRadius: BorderRadius.circular(ThemeDimens.system_tab_radius),
        child: Padding(
          padding: const EdgeInsets.all(ThemeDimens.offset_medium),
          child: Text(
            searchHot.hotKey,
            style: TextStyle(
                fontSize: ThemeDimens.font_size_small, color: searchHot.color),
          ),
        ),
      ),
    );
  }

  Widget buildSearchHistory(SearchViewModel viewModel) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSearchHistoryLabel(viewModel),
        buildSearchHistoryEmpty(viewModel),
        buildSearchHistoryList(viewModel),
      ],
    ));
  }

  Widget buildSearchHistoryLabel(SearchViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
            padding: const EdgeInsets.only(
                left: ThemeDimens.offset_large,
                top: ThemeDimens.offset_large,
                right: ThemeDimens.offset_large,
                bottom: ThemeDimens.offset_medium),
            child: Text(
              ThemeStrings.search_history_label,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: ThemeDimens.font_size_medium),
            )),
        Padding(
            padding: const EdgeInsets.only(
                left: ThemeDimens.offset_large,
                top: ThemeDimens.offset_large,
                right: ThemeDimens.offset_large,
                bottom: ThemeDimens.offset_medium),
            child: Material(
              child: InkWell(
                onTap: () {
                  viewModel.clearSearchHistory();
                },
                child: Text(ThemeStrings.search_clear_text,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: ThemeDimens.font_size_medium)),
              ),
            )),
      ],
    );
  }

  Widget buildSearchHistoryList(SearchViewModel viewModel) {
    var searchHistoryList = viewModel.searchHistoryList
        .map((e) => buildSearchHistoryItem(viewModel, e))
        .toList();

    return Expanded(
        child: Padding(
            padding: const EdgeInsets.only(
                left: ThemeDimens.offset_large,
                right: ThemeDimens.offset_large),
            child: OverscrollHideContainer(
              scrollChild:
                  ListView(shrinkWrap: true, children: searchHistoryList),
            )));
  }

  Widget buildSearchHistoryEmpty(SearchViewModel viewModel) {
    if (viewModel.searchHistoryList.isEmpty) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 26),
          child: Center(
            child: Text(
              ThemeStrings.search_history_empty_text,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: ThemeDimens.font_size_medium),
            ),
          ),
        ),
      );
    }
    return Container();
  }

  Widget buildSearchHistoryItem(
      SearchViewModel viewModel, SearchHistory searchHistory) {
    return Material(
      child: InkWell(
        onTap: () {
          viewModel.navigationSearchKey(searchHistory.searchKey);
        },
        child: Padding(
          padding: const EdgeInsets.only(
              top: ThemeDimens.offset_medium,
              bottom: ThemeDimens.offset_medium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                searchHistory.searchKey,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: ThemeDimens.font_size_small),
              ),
              InkWell(
                onTap: () {
                  viewModel.deleteSearchHistory(searchHistory);
                },
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Theme.of(context).primaryColorLight,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
