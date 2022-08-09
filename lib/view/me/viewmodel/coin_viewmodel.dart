import 'dart:ui';

import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/model/entity/coin_record.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/tools/status_tools.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:playflutter/view/me/model/me_model.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 积分页面viewModel
class CoinViewModel extends BaseViewModel {
  final _model = MeModel();
  late AccountService accountService;
  late VoidCallback _accountListener;
  late Paging<CoinRecord> paging;

  CoinViewModel(super.context);

  @override
  void init() {
    accountService = context.read<AccountService>();
    accountService.addListener(_accountListener = () => notifyListeners());
    paging = Paging.build(notifier: this);
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    accountService.removeListener(_accountListener);
    paging.dispose();
    _model.dispose();
  }

  @override
  void onResume() {
    StatusTools.updateStatusBarIcon(Brightness.dark);
  }

  @override
  void onPause() {}

  void requestData(LoadStatus status) async {
    LogTools.log("Coin", "requestData - $status");

    // request coin list data.
    paging.requestData(status,
        (page) => _model.getCoinRecordAsync(page).then((value) => value.data));
  }
}
