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
  void unInit() {}

  void requestTabData() {
    localRequest<TabData>(
        ThemeConstants.OFFICIAL_TAB_LOCAL_KEY,
        (json) => TabData.fromJson(json),
        _model.getOfficialTabDataAsync(), (value) {
      if (value.data.isEmpty) {
        pageStatus = PageStatus.empty;
      } else {
        tabList = value.data;
        pageStatus = PageStatus.completed;
      }
      notifyListeners();
    }, (error) {
      pageStatus = PageStatus.error;
      notifyListeners();
    });
  }
}
