import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/me/model/collect_model.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 收藏列表viewModel
class CollectViewModel extends ViewModel {
  final _model = CollectModel();
  late Paging<Content> paging;

  CollectViewModel(super.context);

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
    LogTools.log("Collect", "requestData - $status");

    // request collect list data.
    paging.requestData(status,
        (page) => _model.getCollectListAsync(page).then((value) => value.data));
  }
}
