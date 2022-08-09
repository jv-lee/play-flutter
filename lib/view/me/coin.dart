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
              child: Column(
                children: [
                  buildHeader(viewModel),
                  Expanded(child: buildRecordContent(viewModel)),
                ],
              ),
            ));
  }

  Widget buildHeader(CoinViewModel viewModel) {
    return Stack(
      children: [
        AppBar(
            title: const Text(ThemeStrings.me_item_coin,
                style: TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                  onPressed: () => Navigator.pushNamed(
                      context, RouteNames.details,
                      arguments: viewModel.viewStates.detailsData),
                  icon: SvgPicture.asset(ThemeImages.common_help_svg))
            ],
            backgroundColor: Theme.of(context).focusColor,
            foregroundColor: Colors.white,
            elevation: 0.0),
        Padding(
          padding: EdgeInsets.only(top: StatusTools.getAppBarLayoutHeight()),
          child: Stack(
            children: [buildHeaderBackground(), buildHeaderContent(viewModel)],
          ),
        )
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

  Widget buildHeaderContent(CoinViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(
          left: ThemeDimens.offset_large,
          right: ThemeDimens.offset_large,
          top: ThemeDimens.offset_medium),
      child: Card(
        color: Theme.of(context).cardColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(ThemeDimens.offset_radius_medium))),
        child: SizedBox(
          width: double.infinity,
          height: 180,
          child: Column(children: [
            // 每天登陆赚取积分 item
            Container(
              width: double.infinity,
              height: 26,
              decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor,
                  borderRadius: const BorderRadius.only(
                      topLeft:
                          Radius.circular(ThemeDimens.offset_radius_medium),
                      topRight:
                          Radius.circular(ThemeDimens.offset_radius_medium))),
              child: Align(
                alignment: Alignment.center,
                child: Text(ThemeStrings.coin_title_label_text,
                    style: TextStyle(
                        fontSize: ThemeDimens.font_size_small,
                        color: Theme.of(context).focusColor)),
              ),
            ),
            // 当前积分总数 item
            Padding(
                padding: const EdgeInsets.all(ThemeDimens.offset_large),
                child: Text(ThemeStrings.coin_total_description,
                    style: TextStyle(
                        fontSize: ThemeDimens.font_size_small_x,
                        color: Theme.of(context).primaryColor))),
            // 积分数值显示 item
            Padding(
                padding: const EdgeInsets.all(ThemeDimens.offset_medium),
                child: Text(viewModel.findCoinCount(),
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorLight))),
            // 间隔线 item
            Padding(
                padding: const EdgeInsets.only(
                    left: ThemeDimens.offset_large,
                    right: ThemeDimens.offset_large,
                    top: ThemeDimens.offset_medium),
                child:
                    Container(height: 1, color: Theme.of(context).hoverColor)),
            // 查看积分排行榜 item
            Expanded(
                child: SizedBox(
              width: double.infinity,
              child: Material(
                child: InkWell(
                    onTap: () =>
                        {Navigator.pushNamed(context, RouteNames.coin_rank)},
                    borderRadius: const BorderRadius.only(
                        bottomLeft:
                            Radius.circular(ThemeDimens.offset_radius_medium),
                        bottomRight:
                            Radius.circular(ThemeDimens.offset_radius_medium)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: ThemeDimens.offset_large),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ThemeStrings.coin_to_rank_text,
                              style: TextStyle(
                                  fontSize: ThemeDimens.font_size_medium,
                                  color: Theme.of(context).primaryColorLight)),
                          SvgPicture.asset(
                            ThemeImages.common_arrow_svg,
                            width: 24,
                            height: 24,
                            color: Theme.of(context).primaryColorLight,
                          )
                        ],
                      ),
                    )),
              ),
            ))
          ]),
        ),
      ),
    );
  }

  Widget buildRecordContent(CoinViewModel viewModel) {
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
            var item = viewModel.paging.data[index];
            return buildRecordItem(item);
          },
        ));
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
