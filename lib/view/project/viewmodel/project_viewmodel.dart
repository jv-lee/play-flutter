import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/entity/tab.dart';
import 'package:playflutter/view/project/model/project_model.dart';
import 'package:playflutter/widget/status/status.dart';

/// @author jv.lee
/// @date 2022/7/27
/// @description
class ProjectViewModel extends ViewModel {
  final ProjectModel _model = ProjectModel();
  late var pageStatus = PageStatus.loading;
  late var tabList = <Tab>[];

  @override
  void init() {
    requestTabData();
  }

  @override
  void unInit() {}

  void requestTabData() {
    _model.getProjectTabDataAsync().then((value) {
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
