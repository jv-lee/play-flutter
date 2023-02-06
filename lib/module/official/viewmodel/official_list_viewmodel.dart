import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/tools/log_tools.dart';
import 'package:playflutter/core/tools/paging/paging.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/module/official/model/official_model.dart';

/// @author jv.lee
/// @date 2022/7/26
/// @description
class OfficialListViewModel extends BaseViewModel {
  final _officialModel = OfficialModel();
  late int id;
  late Paging<Content> paging;

  OfficialListViewModel(super.context, this.id);

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
    LogTools.log("OfficialList", "requestData id $id - $status");

    // request square list data.
    paging.requestData(
        status,
        (page) => _officialModel
            .getOfficialListDataAsync(page, id)
            .then((value) => value.data));
  }
}
