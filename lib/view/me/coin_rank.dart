import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/model/entity/coin_rank.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/me/viewmodel/coin_rank_viewmodel.dart';
import 'package:playflutter/widget/status/super_list_view.dart';

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
              appBar: AppBar(title: const Text(ThemeStrings.coinRankTitle)),
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
            statusController: viewModel.paging.statusController,
            itemCount: viewModel.paging.data.length,
            onPageReload: () => viewModel.requestData(LoadStatus.refresh),
            onItemReload: () => viewModel.requestData(LoadStatus.reload),
            onLoadMore: () => viewModel.requestData(LoadStatus.loadMore),
            headerChildren: [buildRankHeader(viewModel)],
            itemBuilder: (BuildContext context, int index) {
              var item = viewModel.paging.data[index];
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
            padding: const EdgeInsets.all(ThemeDimens.offsetLarge),
            child: Column(children: [
              SvgPicture.asset(viewModel.findLevelIcon(item),
                  width: 24, height: 24),
              Padding(
                  padding: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
                  child: Text(item.username,
                      maxLines: 1,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: ThemeDimens.fontSizeMedium,
                          overflow: TextOverflow.ellipsis))),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SvgPicture.asset(ThemeImages.meUserCoinSvg,
                    width: 24, height: 24),
                Text(item.coinCount.toString(),
                    maxLines: 1,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: ThemeDimens.fontSizeSmall,
                        fontWeight: FontWeight.bold))
              ])
            ])));
  }

  Widget buildRankItem(CoinRank item) {
    return Container(
        padding: const EdgeInsets.all(ThemeDimens.offsetLarge),
        child: Row(children: [
          Text(item.rank,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: ThemeDimens.fontSizeLarge,
                  fontWeight: FontWeight.bold)),
          Expanded(
              child: Text(item.username,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontSize: ThemeDimens.fontSizeMedium,
                      overflow: TextOverflow.ellipsis))),
          Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            SvgPicture.asset(ThemeImages.meUserCoinSvg, width: 24, height: 24),
            Text(item.coinCount.toString(),
                maxLines: 1,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: ThemeDimens.fontSizeSmall,
                    fontWeight: FontWeight.bold))
          ]))
        ]));
  }
}
