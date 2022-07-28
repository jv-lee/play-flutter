import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/system/model/system_model.dart';
import 'package:playflutter/widget/status/status.dart';
import 'package:playflutter/widget/status/status_controller.dart';

/// @author jv.lee
/// @date 2022/7/26
/// @description
class SystemContentListViewModel extends ViewModel {
  final SystemModel _model = SystemModel();
  late int id;
  late Paging<Content> paging;

  SystemContentListViewModel(super.context, this.id);

  @override
  void init() {
    paging = Paging(
        data: [],
        initPage: 0,
        notify: notifyListeners,
        statusController: StatusController(pageStatus: PageStatus.loading));
    requestData(LoadStatus.refresh);
  }

  @override
  void unInit() {
    paging.dispose();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("SystemContentList:requestData id $id - $status");

    // request square list data.
    paging.requestData(
        status,
        (page) =>
            _model.getContentDataAsync(page, id).then((value) => value.data));
  }
}
