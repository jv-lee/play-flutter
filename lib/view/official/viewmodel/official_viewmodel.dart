import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/model/entity/tab.dart';
import 'package:playflutter/theme/theme_constants.dart';
import 'package:playflutter/tools/local_tools.dart';
import 'package:playflutter/view/official/model/official_model.dart';
import 'package:playflutter/widget/status/status.dart';

/// @author jv.lee
/// @date 2022/7/27
/// @description
class OfficialViewModel extends BaseViewModel {
  final OfficialModel _model = OfficialModel();
  final viewStates = _OfficialViewState();

  OfficialViewModel(super.context);

  @override
  void init() {
    requestTabData();
  }

  @override
  void onCleared() {}

  void requestTabData() {
    LocalTools.localRequest<TabData>(
        localKey: ThemeConstants.OFFICIAL_TAB_LOCAL_KEY,
        createJson: (json) => TabData.fromJson(json),
        requestFuture: _model.getOfficialTabDataAsync(),
        callback: (value) {
          if (value.data.isEmpty) {
            viewStates.pageStatus = PageStatus.empty;
          } else {
            viewStates.tabList = value.data;
            viewStates.pageStatus = PageStatus.completed;
          }
          notifyListeners();
        },
        onError: (error) {
          viewStates.pageStatus = PageStatus.error;
          notifyListeners();
        });
  }
}

class _OfficialViewState {
  var pageStatus = PageStatus.loading;
  var tabList = <Tab>[];
}
