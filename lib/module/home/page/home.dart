import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/extensions/data_format_extensions.dart';
import 'package:playflutter/core/model/entity/banner.dart';
import 'package:playflutter/core/theme/theme_images.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/core/widget/common/banner_view.dart';
import 'package:playflutter/core/widget/common/header/app_header_container.dart';
import 'package:playflutter/core/widget/common/header/app_header_spacer.dart';
import 'package:playflutter/core/widget/common/header/app_text_action_bar.dart';
import 'package:playflutter/core/widget/common/transparent_scaffold.dart';
import 'package:playflutter/core/widget/item/content_item.dart';
import 'package:playflutter/core/widget/status/super_list_view.dart';
import 'package:playflutter/module/details/details_route_names.dart';
import 'package:playflutter/module/home/model/entity/home_category.dart';
import 'package:playflutter/module/home/theme/theme_home.dart';
import 'package:playflutter/module/home/viewmodel/home_viewmodel.dart';
import 'package:playflutter/module/home/widget/item/category_item.dart';
import 'package:playflutter/module/search/search_route_names.dart';

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
                child: Stack(children: [
              RefreshIndicator(
                  displacement: 10,
                  edgeOffset: AppHeaderSpacer.spacerHeight(),
                  color: Theme.of(context).primaryColorLight,
                  onRefresh: () async {
                    await Future<void>.delayed(const Duration(seconds: 1),
                        () => viewModel.requestData(LoadStatus.refresh));
                  },
                  child: SuperListView(
                      statusController:
                          viewModel.viewStates.paging.statusController,
                      scrollController:
                          viewModel.viewStates.paging.scrollController,
                      itemCount: viewModel.viewStates.paging.data.length,
                      onPageReload: () =>
                          viewModel.requestData(LoadStatus.refresh),
                      onItemReload: () =>
                          viewModel.requestData(LoadStatus.reload),
                      onLoadMore: () =>
                          viewModel.requestData(LoadStatus.loadMore),
                      headerChildren: [
                        const AppHeaderSpacer(),
                        buildBanner(
                            viewModel,
                            (item) => Navigator.pushNamed(
                                context, DetailsRouteNames.details,
                                arguments: item.transformDetails())),
                        buildCategory(viewModel,
                            (item) => Navigator.pushNamed(context, item.link))
                      ],
                      itemBuilder: (BuildContext context, int index) {
                        var item = viewModel.viewStates.paging.data[index];
                        return ContentItem(
                            content: item,
                            onItemClick: (item) => Navigator.pushNamed(
                                context, DetailsRouteNames.details,
                                arguments: item.transformDetails()));
                      })),
              AppHeaderContainer(
                  child: AppTextActionBar(
                      title: ThemeHome.strings.headerText,
                      navigationSvgPath: ThemeImages.searchSvg,
                      onNavigationClick: () =>
                          Navigator.pushNamed(context, SearchRouteNames.search)))
            ])));
  }

  Widget buildBanner(
      HomeViewModel viewModel, Function(BannerItem) onItemClick) {
    var bannerList = viewModel.viewStates.bannerList;
    var bannerIndex = viewModel.viewStates.bannerIndex;
    if (bannerList.isEmpty) {
      return Container();
    } else {
      return BannerView(
          initialPage: bannerIndex,
          itemCount: bannerList.length,
          controller: viewModel.viewStates.bannerViewController,
          onIndexChange: (index) => viewModel.viewStates.bannerIndex = index,
          indexedWidgetBuilder: (context, index) =>
              BannerView.defaultBannerItem(bannerList[index].imagePath,
                  onItemTap: () => onItemClick(bannerList[index])),
          indexedIndicatorBuilder: (context, index) =>
              BannerView.defaultIndicator(index, bannerList));
    }
  }

  Widget buildCategory(
      HomeViewModel viewModel, Function(HomeCategory) onItemClick) {
    var categoryList = viewModel.viewStates.categoryList;
    if (categoryList.isEmpty) {
      return Container();
    } else {
      return SizedBox(
          height: ThemeHome.dimens.categoryLayoutHeight,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => CategoryItem(
                  category: categoryList[index], onItemClick: onItemClick)));
    }
  }
}
