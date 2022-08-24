import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/event/constants/event_constants.dart';
import 'package:playflutter/event/entity/tab_selected_event.dart';
import 'package:playflutter/event/events_bus.dart';
import 'package:playflutter/extensions/common_extensions.dart';
import 'package:playflutter/model/entity/banner.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/theme/theme_constants.dart';
import 'package:playflutter/tools/local_tools.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/local_paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/home/model/entity/home_category.dart';
import 'package:playflutter/view/home/model/home_model.dart';
import 'package:playflutter/view/main/model/entity/main_tab_page.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description home页面viewModel
class HomeViewModel extends BaseViewModel {
  final _model = HomeModel();
  final viewStates = _HomeViewState();
  late LocalPaging<Content> paging;

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

  void _requestHeaderData() async {
    LocalTools.localRequest<BannerData>(
        localKey: ThemeConstants.LOCAL_HOME_BANNER,
        createJson: (json) => BannerData.fromJson(json),
        requestFuture: _model.getBannerDataAsync(),
        callback: (value) {
          viewStates.bannerList.clear();
          viewStates.bannerList.addAll(value.data);
        },
        onError: (onError) {
          onFailedToast(onError);
        });

    viewStates.categoryList.clear();
    viewStates.categoryList.addAll(HomeCategory.getHomeCategory());
  }

  void changeBannerIndex(int index) {
    viewStates.bannerIndex = index;
    notifyListeners();
  }

  /// 全局事件 mainTab被点击回调
  void _onTabSelectedEvent(dynamic arg) {
    if (arg is TabSelectedEvent) {
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
