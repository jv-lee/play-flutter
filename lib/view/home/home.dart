import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:playflutter/entity/banner.dart';
import 'package:playflutter/entity/home_category.dart';
import 'package:playflutter/extensions/data_format_extensions.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/theme/theme_svg_paths.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/home/viewmodel/home_viewmodel.dart';
import 'package:playflutter/widget/common/app_gradient_text_bar.dart';
import 'package:playflutter/widget/common/app_header_container.dart';
import 'package:playflutter/widget/common/app_header_spacer.dart';
import 'package:playflutter/widget/item/category_item.dart';
import 'package:playflutter/widget/item/content_item.dart';
import 'package:playflutter/widget/status/super_list_view.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 首页homeTab
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive =>
      true; // 设置wantKeepAlive = true; pagerView切换时不会重新加载view状态

  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().bindView(this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var viewModel = context.read<HomeViewModel>();
    return Stack(
      children: [
        RefreshIndicator(
            color: Theme.of(context).primaryColorLight,
            onRefresh: () async {
              viewModel.requestHomeData(LoadStatus.refresh);
            },
            child: SuperListView(
              statusController:
                  Provider.of<HomeViewModel>(context).paging.statusController,
              itemCount: Provider.of<HomeViewModel>(context).paging.data.length,
              onPageReload: () {
                viewModel.requestHomeData(LoadStatus.refresh);
              },
              onItemReload: () {
                viewModel.requestHomeData(LoadStatus.reload);
              },
              onLoadMore: () {
                viewModel.requestHomeData(LoadStatus.loadMore);
              },
              headerChildren: [
                const AppHeaderSpacer(),
                buildBanner((item) => {
                      Navigator.pushNamed(context, RouteNames.details,
                          arguments: item.transformDetails())
                    }),
                buildCategory(
                    (item) => {Navigator.pushNamed(context, item.link)})
              ],
              itemBuilder: (BuildContext context, int index) {
                var item =
                    Provider.of<HomeViewModel>(context).paging.data[index];
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
            child: AppGradientTextBar(
          title: ThemeStrings.home_header_text,
          navigationSvgPath: ThemeSvgPaths.svg_search,
          onNavigationClick: () {
            Navigator.pushNamed(context, RouteNames.search);
          },
        ))
      ],
    );
  }

  Widget buildBanner(Function(BannerItem) onItemClick) {
    var bannerList = Provider.of<HomeViewModel>(context).bannerList;
    if (bannerList.isEmpty) {
      return Container();
    } else {
      return SizedBox(
        height: ThemeDimens.banner_height,
        child: Swiper(
            viewportFraction: 0.85,
            autoplay: true,
            duration: 300,
            itemCount: bannerList.length,
            itemBuilder: (BuildContext context, int index) {
              var item = bannerList[index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        ThemeDimens.offset_radius_medium)),
                child: Material(
                  child: InkWell(
                    onTap: () => {onItemClick(item)},
                    borderRadius:
                        BorderRadius.circular(ThemeDimens.offset_radius_medium),
                    child: CachedNetworkImage(
                      imageUrl: item.imagePath,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              ThemeDimens.offset_radius_medium),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        color: Theme.of(context).splashColor,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              );
            },
            pagination: const SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    activeSize: 6,
                    size: 6,
                    color: Colors.grey,
                    activeColor: Colors.white))),
      );
    }
  }

  Widget buildCategory(Function(HomeCategory) onItemClick) {
    var categoryList = Provider.of<HomeViewModel>(context).categoryList;
    if (categoryList.isEmpty) {
      return Container();
    } else {
      return SizedBox(
        height: ThemeDimens.category_layout_height,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              var item = categoryList[index];
              return CategoryItem(
                category: item,
                onItemClick: onItemClick,
              );
            }),
      );
    }
  }
}
