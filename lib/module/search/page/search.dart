// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/widget/common/overscroll_hide_container.dart';
import 'package:playflutter/module/search/model/entity/search_history.dart';
import 'package:playflutter/module/search/model/entity/search_hot_ui.dart';
import 'package:playflutter/module/search/theme/theme_search.dart';
import 'package:playflutter/module/search/viewmodel/search_viewmodel.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 搜索页
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchState();

  static const String ARG_SEARCH_KEY = "searchKey";
}

class _SearchState extends BasePageState<SearchPage> {
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
                body: buildSearchContent(viewModel))));
  }

  PreferredSizeWidget buildSearchAppBar(SearchViewModel viewModel) {
    return AppBar(
        title: TextField(
            onSubmitted: (text) => viewModel.navigationSearchKey(text),
            textInputAction: TextInputAction.search,
            decoration:
                InputDecoration(hintText: ThemeSearch.strings.searchHintText)));
  }

  Widget buildSearchContent(SearchViewModel viewModel) {
    return SizedBox(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          buildSearchHot(viewModel),
          buildSearchHistory(viewModel)
        ]));
  }

  Widget buildSearchHot(SearchViewModel viewModel) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      buildSearchHotLabel(viewModel),
      buildSearchHotFlow(viewModel)
    ]);
  }

  Widget buildSearchHotLabel(SearchViewModel viewModel) {
    return Container(
        padding: EdgeInsets.all(ThemeCommon.dimens.offsetLarge),
        child: Text(ThemeSearch.strings.searchHotLabel,
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: ThemeCommon.dimens.fontSizeMedium)));
  }

  Widget buildSearchHotFlow(SearchViewModel viewModel) {
    var widgets = viewModel.viewStates.searchHots
        .map((e) => buildSearchHotFlowItem(viewModel, e))
        .toList();

    return Container(
        padding: EdgeInsets.only(
            left: ThemeCommon.dimens.offsetLarge,
            right: ThemeCommon.dimens.offsetLarge),
        child: Wrap(spacing: -4, runSpacing: -2, children: widgets));
  }

  Widget buildSearchHotFlowItem(
      SearchViewModel viewModel, SearchHotUI searchHot) {
    return Card(
        elevation: 0,
        color: Theme.of(context).hintColor,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(ThemeCommon.dimens.offsetRadiusMedium)),
        child: InkWell(
            onTap: () => viewModel.navigationSearchKey(searchHot.hotKey),
            borderRadius:
                BorderRadius.circular(ThemeCommon.dimens.offsetRadiusSmall),
            child: Padding(
                padding: EdgeInsets.all(ThemeCommon.dimens.offsetMedium),
                child: Text(searchHot.hotKey,
                    style: TextStyle(
                        fontSize: ThemeCommon.dimens.fontSizeSmall,
                        color: searchHot.color)))));
  }

  Widget buildSearchHistory(SearchViewModel viewModel) {
    return Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      buildSearchHistoryLabel(viewModel),
      buildSearchHistoryEmpty(viewModel),
      buildSearchHistoryList(viewModel)
    ]));
  }

  Widget buildSearchHistoryLabel(SearchViewModel viewModel) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(
              left: ThemeCommon.dimens.offsetLarge,
              top: ThemeCommon.dimens.offsetLarge,
              right: ThemeCommon.dimens.offsetLarge,
              bottom: ThemeCommon.dimens.offsetMedium),
          child: Text(ThemeSearch.strings.searchHistoryLabel,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: ThemeCommon.dimens.fontSizeMedium))),
      Padding(
          padding: EdgeInsets.only(
              left: ThemeCommon.dimens.offsetLarge,
              top: ThemeCommon.dimens.offsetLarge,
              right: ThemeCommon.dimens.offsetLarge,
              bottom: ThemeCommon.dimens.offsetMedium),
          child: Material(
              child: InkWell(
                  onTap: () => viewModel.clearSearchHistory(),
                  child: Text(ThemeSearch.strings.searchClearText,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: ThemeCommon.dimens.fontSizeMedium)))))
    ]);
  }

  Widget buildSearchHistoryList(SearchViewModel viewModel) {
    var searchHistoryList = viewModel.viewStates.searchHistoryList
        .map((e) => buildSearchHistoryItem(viewModel, e))
        .toList();

    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(
                left: ThemeCommon.dimens.offsetLarge,
                right: ThemeCommon.dimens.offsetLarge),
            child: OverscrollHideContainer(
                scrollChild:
                    ListView(shrinkWrap: true, children: searchHistoryList))));
  }

  Widget buildSearchHistoryEmpty(SearchViewModel viewModel) {
    return Visibility(
        visible: viewModel.viewStates.searchHistoryList.isEmpty,
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 26),
            child: Center(
                child: Text(ThemeSearch.strings.searchHistoryEmptyText,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: ThemeCommon.dimens.fontSizeMedium)))));
  }

  Widget buildSearchHistoryItem(
      SearchViewModel viewModel, SearchHistory searchHistory) {
    return Material(
        child: InkWell(
            onTap: () => viewModel.navigationSearchKey(searchHistory.searchKey),
            child: Container(
                padding: EdgeInsets.only(
                    top: ThemeCommon.dimens.offsetMedium,
                    bottom: ThemeCommon.dimens.offsetMedium),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        searchHistory.searchKey,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: ThemeCommon.dimens.fontSizeSmall),
                      ),
                      InkWell(
                          onTap: () =>
                              viewModel.deleteSearchHistory(searchHistory),
                          child: Icon(Icons.close,
                              size: 16,
                              color: Theme.of(context).primaryColorLight))
                    ]))));
  }
}
