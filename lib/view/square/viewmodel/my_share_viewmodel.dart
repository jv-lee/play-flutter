import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/square/model/square_model.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 我的分享页面viewModel
class MyShareViewModel extends BaseViewModel {
  final _model = SquareModel();
  late Paging<Content> paging;

  MyShareViewModel(super.context);

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
    LogTools.log("MyShare", "requestData - $status");

    // request square list data.
    paging.requestData(status,
        (page) => _model.getMyShareDataSync(page).then((value) => value.data));
  }
}
