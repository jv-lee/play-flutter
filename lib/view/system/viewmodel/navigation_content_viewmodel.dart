import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/entity/navigation_tab.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/system/model/system_model.dart';
import 'package:playflutter/widget/status/status.dart';
import 'package:playflutter/widget/status/status_controller.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class NavigationContentViewModel extends ViewModel {
  final _model = SystemModel();

  late Paging<NavigationTab> paging;
  var tabSelectedIndex = 0;

  @override
  void init() {
    paging = Paging(
        data: [],
        initPage: 1,
        notify: postViewState,
        statusController: StatusController(pageStatus: PageStatus.loading));
    requestData();
  }

  void requestData() async {
    LogTools.log("NavigationContent:requestData");

    // request systemContent list data.
    paging.requestData(
        LoadStatus.refresh, (page) => _model.getNavigationTabAsync());
  }

  void changeTabIndex(int index) {
    setViewState(() => {tabSelectedIndex = index});
  }
}
