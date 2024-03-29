import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/event/constants/event_constants.dart';
import 'package:playflutter/core/event/entity/tab_selected_event.dart';
import 'package:playflutter/core/event/events_bus.dart';
import 'package:playflutter/core/extensions/exception_extensions.dart';
import 'package:playflutter/core/model/entity/banner.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/tools/cache/preferences.dart';
import 'package:playflutter/core/tools/log_tools.dart';
import 'package:playflutter/core/tools/paging/local_paging.dart';
import 'package:playflutter/core/tools/paging/paging.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/core/widget/common/banner_view.dart';
import 'package:playflutter/module/home/model/entity/home_category.dart';
import 'package:playflutter/module/home/model/home_model.dart';
import 'package:playflutter/module/home/theme/theme_home.dart';
import 'package:playflutter/module/main/model/entity/main_tab_page.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description home页面viewModel
class HomeViewModel extends BaseViewModel {
  final _homeModel = HomeModel();
  final viewStates = _HomeViewState();

  HomeViewModel(super.context);

  @override
  void init() {
    eventBus.bind(EventConstants.EVENT_TAB_SELECTED, _onTabSelectedEvent);
    viewStates.paging = LocalPaging.build(
        notifier: this,
        localKey: ThemeHome.constants.homeList,
        createJson: (json) => ContentDataPage.fromJson(json));
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    eventBus.unbind(EventConstants.EVENT_TAB_SELECTED, _onTabSelectedEvent);
    viewStates.paging.dispose();
    _homeModel.dispose();
  }

  @override
  void onResume() {
    viewStates.bannerViewController.startLoop();
  }

  @override
  void onPause() {
    viewStates.bannerViewController.stopLoop();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("Home", "requestData - $status");

    if (status == LoadStatus.refresh) {
      _requestHeaderData();
    }

    // request content list data.
    viewStates.paging.requestData(status,
        (page) => _homeModel.getContentDataAsync(page).then((value) => value.data));
  }

  void _requestHeaderData() async {
    Preferences.requestCache<BannerData>(
        localKey: ThemeHome.constants.homeBanner,
        createJson: (json) => BannerData.fromJson(json),
        requestFuture: _homeModel.getBannerDataAsync(),
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
      arg.onEvent(MainTabPage.tabHome, viewStates.paging.scrollController);
      notifyListeners();
    }
  }
}

class _HomeViewState {
  late Paging<Content> paging;
  int bannerIndex = 0;
  List<BannerItem> bannerList = [];
  List<HomeCategory> categoryList = [];
  BannerViewController bannerViewController = BannerViewController();
}
