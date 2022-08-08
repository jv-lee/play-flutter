import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/entity/banner.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/home/model/entity/home_category.dart';
import 'package:playflutter/view/home/model/home_model.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description home页面viewModel
class HomeViewModel extends BaseViewModel {
  final _model = HomeModel();

  late SwiperController swiperController;
  late Paging<Content> paging;
  int bannerIndex = 0;
  List<BannerItem> bannerList = [];
  List<HomeCategory> categoryList = [];

  HomeViewModel(super.context);

  @override
  void init() {
    swiperController = SwiperController();
    paging = Paging.build(notifier: this);
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    swiperController.dispose();
    paging.dispose();
  }

  @override
  void onResume() {
    swiperController.startAutoplay();
  }

  @override
  void onPause() {
    swiperController.stopAutoplay();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("Home", "requestData - $status");

    if (status == LoadStatus.refresh) {
      BannerData banner = await _model
          .getBannerDataAsync()
          .catchError((error) => paging.submitFailed());
      bannerList.clear();
      bannerList.addAll(banner.data);

      categoryList.clear();
      categoryList.addAll(HomeCategory.getHomeCategory());
    }

    // request content list data.
    paging.requestData(status,
        (page) => _model.getContentDataAsync(page).then((value) => value.data));
  }

  void changeBannerIndex(int index) {
    bannerIndex = index;
    notifyListeners();
  }
}
