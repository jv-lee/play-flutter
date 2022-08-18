import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/event/constants/event_constants.dart';
import 'package:playflutter/event/entity/tab_selected_event.dart';
import 'package:playflutter/event/events_bus.dart';
import 'package:playflutter/model/entity/banner.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
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
  late Paging<Content> paging;

  HomeViewModel(super.context);

  @override
  void init() {
    eventBus.bind(EventConstants.EVENT_TAB_SELECTED, _onTabSelectedEvent);
    paging = Paging.build(notifier: this);
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
      BannerData banner = await _model
          .getBannerDataAsync()
          .catchError((error) => paging.submitFailed());
      viewStates.bannerList.clear();
      viewStates.bannerList.addAll(banner.data);

      viewStates.categoryList.clear();
      viewStates.categoryList.addAll(HomeCategory.getHomeCategory());
    }

    // request content list data.
    paging.requestData(status,
        (page) => _model.getContentDataAsync(page).then((value) => value.data));
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
