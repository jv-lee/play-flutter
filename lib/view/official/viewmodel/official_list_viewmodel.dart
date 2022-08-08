import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/official/model/official_model.dart';

/// @author jv.lee
/// @date 2022/7/26
/// @description
class OfficialListViewModel extends ViewModel {
  final OfficialModel _model = OfficialModel();
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
        (page) => _model
            .getOfficialListDataAsync(page, id)
            .then((value) => value.data));
  }
}
