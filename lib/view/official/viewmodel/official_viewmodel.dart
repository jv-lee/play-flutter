import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/entity/tab.dart';
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
    _model.getOfficialTabDataAsync().then((value) {
      if (value.data.isEmpty) {
        pageStatus = PageStatus.empty;
      } else {
        tabList = value.data;
        pageStatus = PageStatus.completed;
      }
      notifyListeners();
    }).catchError((onError) {
      pageStatus = PageStatus.error;
      notifyListeners();
    });
  }
}
