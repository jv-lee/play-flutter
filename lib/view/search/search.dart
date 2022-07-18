import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel_state.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/search/viewmodel/search_viewmodel.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 搜索页
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends ViewModelState<SearchPage, SearchViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchAppBar(),
      body: buildSearchContent(),
    );
  }

  PreferredSizeWidget buildSearchAppBar() {
    return AppBar(
      title: TextField(
        decoration: InputDecoration(
            hintText: ThemeStrings.search_hint_text,
            hintStyle: TextStyle(color: Theme.of(context).primaryColor),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent))),
        cursorColor: Theme.of(context).primaryColorLight,
      ),
    );
  }

  Widget buildSearchContent() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [buildSearchHot(), buildSearchHistory()],
      ),
    );
  }

  Widget buildSearchHot() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buildSearchHotLabel(), buildSearchHotFlow()],
    );
  }

  Widget buildSearchHotLabel() {
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

  Widget buildSearchHotFlow() {
    List<Widget> widgets = [];
    for (var element in providerOfVM().searchHots) {
      widgets.add(
        Card(
          elevation: 0,
          color: Theme.of(context).hintColor,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(ThemeDimens.offset_radius_medium)),
          child: InkWell(
            onTap: () => {},
            borderRadius: BorderRadius.circular(ThemeDimens.system_tab_radius),
            child: Padding(
              padding: const EdgeInsets.all(ThemeDimens.offset_medium),
              child: Text(
                element.hotKey,
                style: TextStyle(
                    fontSize: ThemeDimens.font_size_small,
                    color: element.color),
              ),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(
          left: ThemeDimens.offset_large, right: ThemeDimens.offset_large),
      child: Wrap(spacing: -4, runSpacing: -2, children: widgets),
    );
  }

  Widget buildSearchHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buildSearchHistoryLabel(), buildSearchHistoryList()],
    );
  }

  Widget buildSearchHistoryLabel() {
    return Padding(
      padding: const EdgeInsets.all(ThemeDimens.offset_large),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ThemeStrings.search_history_label,
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: ThemeDimens.font_size_medium),
          ),
          Text(ThemeStrings.search_clear_text,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: ThemeDimens.font_size_medium))
        ],
      ),
    );
  }

  Widget buildSearchHistoryList() {
    return Column(
      children: [buildSearchHistoryItem()],
    );
  }

  Widget buildSearchHistoryItem() {
    return Padding(
      padding: const EdgeInsets.only(
          left: ThemeDimens.offset_large, right: ThemeDimens.offset_large),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "搜索key",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: ThemeDimens.font_size_small),
          ),
          const Icon(Icons.close, size: 16)
        ],
      ),
    );
  }
}
