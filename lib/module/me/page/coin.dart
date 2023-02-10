import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/model/entity/coin_record.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/core/tools/status_tools.dart';
import 'package:playflutter/core/widget/common/ink_well_container.dart';
import 'package:playflutter/core/widget/common/transparent_scaffold.dart';
import 'package:playflutter/core/widget/status/super_list_view.dart';
import 'package:playflutter/module/details/theme/theme_details.dart';
import 'package:playflutter/module/me/theme/theme_me.dart';
import 'package:playflutter/module/me/viewmodel/coin_viewmodel.dart';

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
        viewBuild: (context, viewModel) => TransparentScaffold(
            color: Theme.of(context).focusColor,
            child: Column(children: [
              buildHeader(viewModel),
              Expanded(child: buildRecordContent(viewModel))
            ])));
  }

  Widget buildHeader(CoinViewModel viewModel) {
    return Stack(children: [
      AppBar(
          title: Text(ThemeMe.strings.meItemCoin,
              style: const TextStyle(color: Colors.white)),
          actions: [
            IconButton(
                onPressed: () => Navigator.pushNamed(
                    context, ThemeDetails.routes.details,
                    arguments: viewModel.viewStates.detailsData),
                icon: SvgPicture.asset(ThemeCommon.images.helpSvg))
          ],
          backgroundColor: Theme.of(context).focusColor,
          foregroundColor: Colors.white,
          elevation: 0.0),
      Container(
          padding: EdgeInsets.only(top: StatusTools.getAppBarLayoutHeight()),
          child: Stack(children: [
            buildHeaderBackground(),
            buildHeaderContent(viewModel)
          ]))
    ]);
  }

  Widget buildHeaderBackground() {
    return Container(
        width: double.infinity,
        height: ThemeMe.dimens.coinHeaderBgHeight,
        decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(56),
                bottomRight: Radius.circular(56))));
  }

  Widget buildHeaderContent(CoinViewModel viewModel) {
    return Card(
        margin: EdgeInsets.only(
            left: ThemeCommon.dimens.offsetLarge,
            right: ThemeCommon.dimens.offsetLarge,
            top: ThemeCommon.dimens.offsetMedium),
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(ThemeCommon.dimens.offsetRadiusMedium))),
        child: SizedBox(
            width: double.infinity,
            height: 180,
            child: Column(children: [
              // 每天登陆赚取积分 item
              Container(
                  width: double.infinity,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).hoverColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              ThemeCommon.dimens.offsetRadiusMedium),
                          topRight: Radius.circular(
                              ThemeCommon.dimens.offsetRadiusMedium))),
                  child: Text(ThemeMe.strings.coinTitleLabelText,
                      style: TextStyle(
                          fontSize: ThemeCommon.dimens.fontSizeSmall,
                          color: Theme.of(context).focusColor))),
              // 当前积分总数 item
              Container(
                  margin: EdgeInsets.all(ThemeCommon.dimens.offsetLarge),
                  child: Text(ThemeMe.strings.coinTotalDescription,
                      style: TextStyle(
                          fontSize: ThemeCommon.dimens.fontSizeSmallX,
                          color: Theme.of(context).primaryColor))),
              // 积分数值显示 item
              Container(
                  margin: EdgeInsets.all(ThemeCommon.dimens.offsetMedium),
                  child: Text(
                      viewModel.accountService.viewStates.coinCount.toString(),
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorLight))),
              // 间隔线 item
              Container(
                  margin: EdgeInsets.only(
                      left: ThemeCommon.dimens.offsetLarge,
                      right: ThemeCommon.dimens.offsetLarge,
                      top: ThemeCommon.dimens.offsetMedium),
                  height: 1,
                  color: Theme.of(context).hoverColor),
              // 查看积分排行榜 item
              Expanded(
                  child: InkWellContainer(
                      onTap: () =>
                          Navigator.pushNamed(context, ThemeMe.routes.coinRank),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              ThemeCommon.dimens.offsetRadiusMedium),
                          bottomRight: Radius.circular(
                              ThemeCommon.dimens.offsetRadiusMedium)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ThemeCommon.dimens.offsetLarge),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(ThemeMe.strings.coinToRankText,
                                  style: TextStyle(
                                      fontSize:
                                          ThemeCommon.dimens.fontSizeMedium,
                                      color:
                                          Theme.of(context).primaryColorLight)),
                              SvgPicture.asset(ThemeCommon.images.arrowSvg,
                                  width: 24,
                                  height: 24,
                                  color: Theme.of(context).primaryColorLight)
                            ]),
                      )))
            ])));
  }

  Widget buildRecordContent(CoinViewModel viewModel) {
    return Padding(
        padding: const EdgeInsets.only(top: 3),
        child: RefreshIndicator(
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
                itemBuilder: (BuildContext context, int index) {
                  var item = viewModel.paging.data[index];
                  return buildRecordItem(item);
                })));
  }

  Widget buildRecordItem(CoinRecord record) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: ThemeCommon.dimens.offsetMedium),
        padding: EdgeInsets.all(ThemeCommon.dimens.offsetLarge),
        alignment: Alignment.center,
        color: Theme.of(context).cardColor,
        child: Text(record.desc,
            maxLines: 1,
            style: TextStyle(
                fontSize: ThemeCommon.dimens.fontSizeSmall,
                color: Theme.of(context).primaryColorLight,
                overflow: TextOverflow.ellipsis)));
  }
}
