import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/model/entity/coin_record.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/tools/status_tools.dart';
import 'package:playflutter/view/me/viewmodel/coin_viewmodel.dart';
import 'package:playflutter/widget/common/ink_well_container.dart';
import 'package:playflutter/widget/common/transparent_scaffold.dart';
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
          title: const Text(ThemeStrings.meItemCoin,
              style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
                onPressed: () => Navigator.pushNamed(
                    context, RouteNames.details,
                    arguments: viewModel.viewStates.detailsData),
                icon: SvgPicture.asset(ThemeImages.commonHelpSvg))
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
        height: ThemeDimens.meCoinHeaderBgHeight,
        decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(56),
                bottomRight: Radius.circular(56))));
  }

  Widget buildHeaderContent(CoinViewModel viewModel) {
    return Card(
        margin: const EdgeInsets.only(
            left: ThemeDimens.offsetLarge,
            right: ThemeDimens.offsetLarge,
            top: ThemeDimens.offsetMedium),
        color: Theme.of(context).cardColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(ThemeDimens.offsetRadiusMedium))),
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
                      borderRadius: const BorderRadius.only(
                          topLeft:
                              Radius.circular(ThemeDimens.offsetRadiusMedium),
                          topRight:
                              Radius.circular(ThemeDimens.offsetRadiusMedium))),
                  child: Text(ThemeStrings.coinTitleLabelText,
                      style: TextStyle(
                          fontSize: ThemeDimens.fontSizeSmall,
                          color: Theme.of(context).focusColor))),
              // 当前积分总数 item
              Container(
                  margin: const EdgeInsets.all(ThemeDimens.offsetLarge),
                  child: Text(ThemeStrings.coinTotalDescription,
                      style: TextStyle(
                          fontSize: ThemeDimens.fontSizeSmallX,
                          color: Theme.of(context).primaryColor))),
              // 积分数值显示 item
              Container(
                  margin: const EdgeInsets.all(ThemeDimens.offsetMedium),
                  child: Text(viewModel.findCoinCount(),
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorLight))),
              // 间隔线 item
              Container(
                  margin: const EdgeInsets.only(
                      left: ThemeDimens.offsetLarge,
                      right: ThemeDimens.offsetLarge,
                      top: ThemeDimens.offsetMedium),
                  height: 1,
                  color: Theme.of(context).hoverColor),
              // 查看积分排行榜 item
              Expanded(
                  child: InkWellContainer(
                      onTap: () =>
                          Navigator.pushNamed(context, RouteNames.coin_rank),
                      borderRadius: const BorderRadius.only(
                          bottomLeft:
                              Radius.circular(ThemeDimens.offsetRadiusMedium),
                          bottomRight:
                              Radius.circular(ThemeDimens.offsetRadiusMedium)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: ThemeDimens.offsetLarge),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(ThemeStrings.coinToRankText,
                                  style: TextStyle(
                                      fontSize: ThemeDimens.fontSizeMedium,
                                      color:
                                          Theme.of(context).primaryColorLight)),
                              SvgPicture.asset(ThemeImages.commonArrowSvg,
                                  width: 24,
                                  height: 24,
                                  color: Theme.of(context).primaryColorLight)
                            ]),
                      )))
            ])));
  }

  Widget buildRecordContent(CoinViewModel viewModel) {
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
            itemBuilder: (BuildContext context, int index) {
              var item = viewModel.paging.data[index];
              return buildRecordItem(item);
            }));
  }

  Widget buildRecordItem(CoinRecord record) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
        padding: const EdgeInsets.all(ThemeDimens.offsetLarge),
        alignment: Alignment.center,
        color: Theme.of(context).cardColor,
        child: Text(record.desc,
            maxLines: 1,
            style: TextStyle(
                fontSize: ThemeDimens.fontSizeSmall,
                color: Theme.of(context).primaryColorLight,
                overflow: TextOverflow.ellipsis)));
  }
}
