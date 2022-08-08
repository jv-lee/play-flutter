import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/entity/tab.dart';
import 'package:playflutter/theme/theme_constants.dart';
import 'package:playflutter/tools/local_tools.dart';
import 'package:playflutter/view/project/model/project_model.dart';
import 'package:playflutter/widget/status/status.dart';

/// @author jv.lee
/// @date 2022/7/27
/// @description
class ProjectViewModel extends BaseViewModel {
  final ProjectModel _model = ProjectModel();
  late var pageStatus = PageStatus.loading;
  late var tabList = <Tab>[];

  ProjectViewModel(super.context);

  @override
  void init() {
    requestTabData();
  }

  @override
  void onCleared() {}

  void requestTabData() {
    LocalTools.localRequest<TabData>(
        localKey: ThemeConstants.PROJECT_TAB_LOCAL_KEY,
        createJson: (json) => TabData.fromJson(json),
        requestFuture: _model.getProjectTabDataAsync(),
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
