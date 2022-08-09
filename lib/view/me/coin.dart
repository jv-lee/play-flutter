import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/model/entity/coin_record.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/tools/status_tools.dart';
import 'package:playflutter/view/me/viewmodel/coin_viewmodel.dart';
import 'package:playflutter/widget/status/super_list_view.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 积分页面
class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<StatefulWidget> createState() => _CoinPageState();
}

class _CoinPageState extends BasePageState<CoinPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<CoinViewModel>(
        create: (context) => CoinViewModel(context),
        viewBuild: (context, viewModel) => Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                  title: const Text(ThemeStrings.me_item_coin,
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Theme.of(context).focusColor,
                  foregroundColor: Colors.white,
                  elevation: 0.0),
              body: Padding(
                padding:
                    EdgeInsets.only(top: StatusTools.getAppBarLayoutHeight()),
                child: Stack(
                  children: [buildRecordContent(viewModel), buildHeader()],
                ),
              ),
            ));
  }

  Widget buildHeader() {
    return Stack(
      children: [
        buildHeaderBackground(),
      ],
    );
  }

  Widget buildHeaderBackground() {
    return Container(
      width: double.infinity,
      height: ThemeDimens.me_coin_header_bg_height,
      decoration: BoxDecoration(
          color: Theme.of(context).focusColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(56),
              bottomRight: Radius.circular(56))),
    );
  }

  Widget buildRecordContent(CoinViewModel viewModel) {
    return Padding(
        padding: const EdgeInsets.only(top: ThemeDimens.me_coin_header_height),
        child: RefreshIndicator(
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
                var item = viewModel.paging.data[index];
                return buildRecordItem(item);
              },
            )));
  }

  Widget buildRecordItem(CoinRecord record) {
    return Padding(
      padding: const EdgeInsets.only(top: ThemeDimens.offset_medium),
      child: Container(
        width: double.infinity,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(ThemeDimens.offset_large),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                record.desc,
                maxLines: 1,
                style: TextStyle(
                    fontSize: ThemeDimens.font_size_small,
                    color: Theme.of(context).primaryColorLight,
                    overflow: TextOverflow.ellipsis),
              )),
        ),
      ),
    );
  }
}
