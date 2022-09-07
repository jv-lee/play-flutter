import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/tools/log_tools.dart';
import 'package:playflutter/core/tools/paging/paging.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/module/project/model/project_model.dart';

/// @author jv.lee
/// @date 2022/7/26
/// @description
class ProjectListViewModel extends BaseViewModel {
  final ProjectModel _model = ProjectModel();
  late int id;
  late Paging<Content> paging;

  ProjectListViewModel(super.context, this.id);

  @override
  void init() {
    paging = Paging.build(notifier: this, initPage: 1);
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    paging.dispose();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("ProjectList", "requestData id $id - $status");

    // request square list data.
    paging.requestData(
        status,
        (page) => _model
            .getProjectListDataAsync(page, id)
            .then((value) => value.data));
  }
}
