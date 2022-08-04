import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/entity/tab.dart';
import 'package:playflutter/theme/theme_constants.dart';
import 'package:playflutter/tools/local_tools.dart';
import 'package:playflutter/view/official/model/official_model.dart';
import 'package:playflutter/widget/status/status.dart';

/// @author jv.lee
/// @date 2022/7/27
/// @description
class OfficialViewModel extends ViewModel {
  final OfficialModel _model = OfficialModel();
  late var pageStatus = PageStatus.loading;
  late var tabList = <Tab>[];

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
            pageStatus = PageStatus.empty;
          } else {
            tabList = value.data;
            pageStatus = PageStatus.completed;
          }
          notifyListeners();
        },
        onError: (error) {
          pageStatus = PageStatus.error;
          notifyListeners();
        });
  }
}
