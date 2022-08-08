import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/system/model/system_model.dart';

/// @author jv.lee
/// @date 2022/7/26
/// @description
class SystemContentListViewModel extends BaseViewModel {
  final SystemModel _model = SystemModel();
  late int id;
  late Paging<Content> paging;

  SystemContentListViewModel(super.context, this.id);

  @override
  void init() {
    paging = Paging.build(notifier: this);
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    paging.dispose();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("SystemContentList","requestData id $id - $status");

    // request square list data.
    paging.requestData(
        status,
        (page) =>
            _model.getContentDataAsync(page, id).then((value) => value.data));
  }
}
