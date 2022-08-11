import 'dart:ui';

import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/model/entity/coin_record.dart';
import 'package:playflutter/model/entity/details.dart';
import 'package:playflutter/model/http/constants/api_constants.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:playflutter/view/me/model/me_model.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 积分页面viewModel
class CoinViewModel extends BaseViewModel {
  final _model = MeModel();
  final viewStates = _CoinViewState();
  late AccountService accountService;
  late VoidCallback _accountListener;
  late Paging<CoinRecord> paging;

  CoinViewModel(super.context);

  @override
  void init() {
    accountService = context.read<AccountService>();
    accountService.addListener(_accountListener = () => notifyListeners());
    paging = Paging.build(notifier: this, initPage: 1);
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    accountService.removeListener(_accountListener);
    paging.dispose();
    _model.dispose();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("Coin", "requestData - $status");

    // request coin list data.
    paging.requestData(status,
        (page) => _model.getCoinRecordAsync(page).then((value) => value.data));
  }

  String findCoinCount() {
    return accountService.viewStates.accountData?.data.coinInfo.coinCount
            .toString() ??
        "0";
  }
}

class _CoinViewState {
  var detailsData = DetailsData(
      title: ThemeStrings.coinHelpTitle, link: ApiConstants.URI_COIN_HELP);
}
