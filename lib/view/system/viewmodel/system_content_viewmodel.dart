import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/model/entity/parent_tab.dart';
import 'package:playflutter/theme/theme_constants.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/local_paging.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/system/model/system_model.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description 体系tab systemContent数据viewModel
class SystemContentViewModel extends BaseViewModel {
  final _model = SystemModel();

  late Paging<ParentTab> paging;

  SystemContentViewModel(super.context);

  @override
  void init() {
    paging = LocalPaging.build(
        notifier: this,
        initPage: 1,
        localKey: ThemeConstants.LOCAL_SYSTEM_LIST,
        createJson: (json) => ParentTabData.fromJson(json));
    requestData();
  }

  @override
  void onCleared() {
    paging.dispose();
    _model.dispose();
  }

  void requestData() async {
    LogTools.log("SystemContent", "requestData");

    // request systemContent list data.
    paging.requestData(LoadStatus.refresh, (page) => _model.getParentTabAsync());
  }
}
