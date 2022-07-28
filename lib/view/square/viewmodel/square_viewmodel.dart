import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/square/model/SquareModel.dart';
import 'package:playflutter/widget/status/status.dart';
import 'package:playflutter/widget/status/status_controller.dart';

/// @author jv.lee
/// @date 2022/6/29
/// @description
class SquareViewModel extends ViewModel {
  final _model = SquareModel();

  late Paging<Content> paging;

  SquareViewModel(super.context);

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
    LogTools.log("Square:requestData - $status");

    // request square list data.
    paging.requestData(status,
        (page) => _model.getSquareDataAsync(page).then((value) => value.data));
  }
}
