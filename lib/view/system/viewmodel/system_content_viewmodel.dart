import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/entity/parent_tab.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/system/model/system_model.dart';
import 'package:playflutter/widget/status/status.dart';
import 'package:playflutter/widget/status/status_controller.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 体系tab systemContent数据viewModel
class SystemContentViewModel extends ViewModel {
  final _model = SystemModel();

  late Paging<ParentTab> paging;

  SystemContentViewModel(super.context);

  @override
  void init() {
    paging = Paging(
        data: [],
        initPage: 1,
        notify: notifyListeners,
        statusController: StatusController(pageStatus: PageStatus.loading));
    requestData();
  }

  @override
  void onCleared() {
    paging.dispose();
  }

  void requestData() async {
    LogTools.log("SystemContent","requestData");

    // request systemContent list data.
    paging.requestData(LoadStatus.reload, (page) => _model.getParentTabAsync());
  }
}
