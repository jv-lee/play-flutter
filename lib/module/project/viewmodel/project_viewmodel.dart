import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/model/entity/tab.dart';
import 'package:playflutter/core/tools/cache/preferences.dart';
import 'package:playflutter/core/widget/status/status.dart';
import 'package:playflutter/module/project/model/project_model.dart';
import 'package:playflutter/module/project/theme/theme_constants_project.dart';

/// @author jv.lee
/// @date 2022/7/27
/// @description
class ProjectViewModel extends BaseViewModel {
  final ProjectModel _model = ProjectModel();
  final viewStates = _ProjectViewState();

  ProjectViewModel(super.context);

  @override
  void init() {
    requestTabData();
  }

  @override
  void onCleared() {}

  void requestTabData() {
    Preferences.requestCache<TabData>(
        localKey: ThemeConstantsProject.LOCAL_PROJECT_TAB,
        createJson: (json) => TabData.fromJson(json),
        requestFuture: _model.getProjectTabDataAsync(),
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

class _ProjectViewState {
  late var pageStatus = PageStatus.loading;
  late var tabList = <Tab>[];
}
