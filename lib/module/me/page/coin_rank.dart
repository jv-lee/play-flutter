import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/model/entity/coin_rank.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/core/widget/status/super_list_view.dart';
import 'package:playflutter/module/me/theme/theme_me.dart';
import 'package:playflutter/module/me/viewmodel/coin_rank_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 积分排行榜页面
class CoinRankPage extends StatefulWidget {
  const CoinRankPage({super.key});

  @override
  State<StatefulWidget> createState() => _CoinRankPageState();
}

class _CoinRankPageState extends BasePageState<CoinRankPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<CoinRankViewModel>(
        create: (context) => CoinRankViewModel(context),
        viewBuild: (context, viewModel) {
          return Scaffold(
              appBar: AppBar(title: Text(ThemeMe.strings.coinRankTitle)),
              body: buildRankContent(viewModel));
        });
  }

  Widget buildRankContent(CoinRankViewModel viewModel) {
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
            headerChildren: [buildRankHeader(viewModel)],
            itemBuilder: (BuildContext context, int index) {
              var item = viewModel.viewStates.paging.data[index];
              return buildRankItem(item);
            }));
  }

  Widget buildRankHeader(CoinRankViewModel viewModel) {
    return Row(
        children: viewModel.viewStates.headerList
            .map((e) => buildRankHeaderItem(viewModel, e))
            .toList());
  }

  Widget buildRankHeaderItem(CoinRankViewModel viewModel, CoinRank item) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(ThemeCommon.dimens.offsetLarge),
            child: Column(children: [
              SvgPicture.asset(viewModel.findLevelIcon(item),
                  width: 24, height: 24),
              Padding(
                  padding:
                      EdgeInsets.only(top: ThemeCommon.dimens.offsetMedium),
                  child: Text(item.username,
                      maxLines: 1,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: ThemeCommon.dimens.fontSizeMedium,
                          overflow: TextOverflow.ellipsis))),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SvgPicture.asset(ThemeMe.images.userCoinSvg,
                    width: 24, height: 24),
                Text(item.coinCount.toString(),
                    maxLines: 1,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: ThemeCommon.dimens.fontSizeSmall,
                        fontWeight: FontWeight.bold))
              ])
            ])));
  }

  Widget buildRankItem(CoinRank item) {
    return Container(
        padding: EdgeInsets.all(ThemeCommon.dimens.offsetLarge),
        child: Row(children: [
          Text(item.rank,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: ThemeCommon.dimens.fontSizeLarge,
                  fontWeight: FontWeight.bold)),
          Expanded(
              child: Text(item.username,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontSize: ThemeCommon.dimens.fontSizeMedium,
                      overflow: TextOverflow.ellipsis))),
          Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            SvgPicture.asset(ThemeMe.images.userCoinSvg, width: 24, height: 24),
            Text(item.coinCount.toString(),
                maxLines: 1,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: ThemeCommon.dimens.fontSizeSmall,
                    fontWeight: FontWeight.bold))
          ]))
        ]));
  }
}
