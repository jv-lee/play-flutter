import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/event/constants/event_constants.dart';
import 'package:playflutter/core/event/entity/tab_selected_event.dart';
import 'package:playflutter/core/event/events_bus.dart';
import 'package:playflutter/core/extensions/exception_extensions.dart';
import 'package:playflutter/core/model/entity/banner.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/theme/theme_constants.dart';
import 'package:playflutter/core/tools/cache/preferences.dart';
import 'package:playflutter/core/tools/log_tools.dart';
import 'package:playflutter/core/tools/paging/local_paging.dart';
import 'package:playflutter/core/tools/paging/paging.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/module/home/model/entity/home_category.dart';
import 'package:playflutter/module/home/model/home_model.dart';
import 'package:playflutter/module/main/model/entity/main_tab_page.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description home页面viewModel
class HomeViewModel extends BaseViewModel {
  final _model = HomeModel();
  final viewStates = _HomeViewState();
  late Paging<Content> paging;

  HomeViewModel(super.context);

  @override
  void init() {
    eventBus.bind(EventConstants.EVENT_TAB_SELECTED, _onTabSelectedEvent);
    paging = LocalPaging.build(
        notifier: this,
        localKey: ThemeConstants.LOCAL_HOME_LIST,
        createJson: (json) => ContentDataPage.fromJson(json));
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    eventBus.unbind(EventConstants.EVENT_TAB_SELECTED, _onTabSelectedEvent);
    viewStates.swiperController.dispose();
    paging.dispose();
    _model.dispose();
  }

  @override
  void onResume() {
    viewStates.swiperController.startAutoplay();
  }

  @override
  void onPause() {
    viewStates.swiperController.stopAutoplay();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("Home", "requestData - $status");

    if (status == LoadStatus.refresh) {
      _requestHeaderData();
    }

    // request content list data.
    paging.requestData(status,
        (page) => _model.getContentDataAsync(page).then((value) => value.data));
  }

  void changeBannerIndex(int index) {
    viewStates.bannerIndex = index;
    notifyListeners();
  }

  void _requestHeaderData() async {
    Preferences.requestCache<BannerData>(
        localKey: ThemeConstants.LOCAL_HOME_BANNER,
        createJson: (json) => BannerData.fromJson(json),
        requestFuture: _model.getBannerDataAsync(),
        callback: (value) async {
          viewStates.bannerList.clear();
          viewStates.bannerList.addAll(value.data);
        },
        onError: (onError) {
          onFailedToast(onError);
        });

    viewStates.categoryList.clear();
    viewStates.categoryList.addAll(HomeCategory.getHomeCategory());
  }

  /// 全局事件 mainTab被点击回调
  void _onTabSelectedEvent(dynamic arg) {
    if (!isDisposed() && arg is TabSelectedEvent) {
      arg.onEvent(MainTabPage.tabHome, paging.scrollController);
      notifyListeners();
    }
  }
}

class _HomeViewState {
  int bannerIndex = 0;
  List<BannerItem> bannerList = [];
  List<HomeCategory> categoryList = [];
  SwiperController swiperController = SwiperController();
}
