import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/home/viewmodel/home_viewmodel.dart';
import 'package:playflutter/widget/common/category_item.dart';
import 'package:playflutter/widget/common/content_item.dart';
import 'package:playflutter/widget/status/super_list_view.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 首页homePage
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
    return RefreshIndicator(
        color: Theme.of(context).primaryColorLight,
        backgroundColor: Theme.of(context).cardColor,
        onRefresh: () async {
          context.read<HomeViewModel>().requestHomeData(LoadStatus.refresh);
        },
        child: SuperListView(
          statusController:
              Provider.of<HomeViewModel>(context).paging.statusController,
          itemCount: Provider.of<HomeViewModel>(context).paging.data.length,
          onPageReload: () {
            context.read<HomeViewModel>().requestHomeData(LoadStatus.refresh);
          },
          onItemReload: () {
            context.read<HomeViewModel>().requestHomeData(LoadStatus.reload);
          },
          onLoadMore: () {
            context.read<HomeViewModel>().requestHomeData(LoadStatus.loadMore);
          },
          headerChildren: [buildBanner(), buildCategory()],
          itemBuilder: (BuildContext context, int index) {
            var item = Provider.of<HomeViewModel>(context).paging.data[index];
            return ContentItem(content: item);
          },
        ));
  }

  Widget buildBanner() {
    var bannerList = Provider.of<HomeViewModel>(context).bannerList;
    return SizedBox(
      height: ThemeDimens.banner_height,
      child: bannerList.isEmpty
          ? Center(
              child: Text(
                ThemeStrings.loading,
                style: TextStyle(color: Theme.of(context).primaryColorLight),
              ),
            )
          : Swiper(
              autoplay: true,
              duration: 300,
              itemCount: bannerList.length,
              itemBuilder: (BuildContext context, int index) {
                return CachedNetworkImage(
                  imageUrl: bannerList[index].imagePath,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    color: Theme.of(context).splashColor,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              },
              pagination: const SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                      activeSize: 6,
                      size: 6,
                      color: Colors.black54,
                      activeColor: Colors.white))),
    );
  }

  Widget buildCategory() {
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
              return CategoryItem(category: item);
            }),
      );
    }
  }
}
