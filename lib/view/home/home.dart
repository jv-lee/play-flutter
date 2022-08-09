import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/model/entity/banner.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/home/model/entity/home_category.dart';
import 'package:playflutter/view/home/viewmodel/home_viewmodel.dart';
import 'package:playflutter/widget/common/app_banner.dart';
import 'package:playflutter/widget/common/header/app_header_container.dart';
import 'package:playflutter/widget/common/header/app_header_spacer.dart';
import 'package:playflutter/widget/common/header/app_text_action_bar.dart';
import 'package:playflutter/widget/common/transparent_scaffold.dart';
import 'package:playflutter/widget/item/category_item.dart';
import 'package:playflutter/widget/item/content_item.dart';
import 'package:playflutter/widget/status/super_list_view.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 首页homeTab
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends BasePageState<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  // 设置wantKeepAlive = true; pagerView切换时不会重新加载view状态
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildViewModel<HomeViewModel>(
        create: (context) => HomeViewModel(context),
        viewBuild: (context, viewModel) => TransparentScaffold(
                child: Stack(
              children: [
                RefreshIndicator(
                    displacement: 10,
                    edgeOffset: AppHeaderSpacer.spacerHeight(),
                    color: Theme.of(context).primaryColorLight,
                    onRefresh: () async {
                      await Future<void>.delayed(const Duration(seconds: 1),
                          () {
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
                      headerChildren: [
                        const AppHeaderSpacer(),
                        buildBanner(
                            viewModel,
                            (item) => {
                                  Navigator.pushNamed(
                                      context, RouteNames.details,
                                      arguments: item.transformDetails())
                                }),
                        buildCategory(viewModel,
                            (item) => {Navigator.pushNamed(context, item.link)})
                      ],
                      itemBuilder: (BuildContext context, int index) {
                        var item = viewModel.paging.data[index];
                        return ContentItem(
                          content: item,
                          onItemClick: (item) => {
                            Navigator.pushNamed(context, RouteNames.details,
                                arguments: item.transformDetails())
                          },
                        );
                      },
                    )),
                AppHeaderContainer(
                    child: AppTextActionBar(
                  title: ThemeStrings.homeHeaderText,
                  navigationSvgPath: ThemeImages.commonSearchSvg,
                  onNavigationClick: () {
                    Navigator.pushNamed(context, RouteNames.search);
                  },
                ))
              ],
            )));
  }

  Widget buildBanner(
      HomeViewModel viewModel, Function(BannerItem) onItemClick) {
    var bannerList = viewModel.viewStates.bannerList;
    var bannerIndex = viewModel.viewStates.bannerIndex;
    if (bannerList.isEmpty) {
      return Container();
    } else {
      return AppBanner(
          controller: viewModel.viewStates.swiperController,
          index: bannerIndex,
          count: bannerList.length,
          onIndexChanged: (index) => viewModel.changeBannerIndex(index),
          onIndexTap: (index) => onItemClick(bannerList[index]),
          findPath: (index) => bannerList[index].imagePath);
    }
  }

  Widget buildCategory(
      HomeViewModel viewModel, Function(HomeCategory) onItemClick) {
    var categoryList = viewModel.viewStates.categoryList;
    if (categoryList.isEmpty) {
      return Container();
    } else {
      return SizedBox(
        height: ThemeDimens.homeCategoryLayoutHeight,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              var item = categoryList[index];
              return CategoryItem(category: item, onItemClick: onItemClick);
            }),
      );
    }
  }
}
