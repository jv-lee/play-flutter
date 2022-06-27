import 'package:flutter/cupertino.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/entity/banner.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/entity/home_category.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/home/model/home_model.dart';
import 'package:playflutter/widget/status/status.dart';
import 'package:playflutter/widget/status/status_controller.dart';

/// @author jv.lee
/// @date 2022/6/23
/// @description home页面viewModel
class HomeViewModel extends ViewModel {
  final _model = HomeModel();

  late Paging<Content> paging;
  List<BannerItem> bannerList = [];
  List<HomeCategory> categoryList = [];

  @override
  void bindView(State<dynamic> viewState) {
    paging = Paging(
        data: [],
        initPage: 0,
        notify: () {
          viewState.setState(() {});
        },
        statusController: StatusController(pageStatus: PageStatus.loading));

    requestHomeData(LoadStatus.refresh);
  }

  void requestHomeData(LoadStatus status) async {
    LogTools.log("requestHomeData - $status");

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
}
