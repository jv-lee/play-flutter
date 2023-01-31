import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/model/entity/coin_record.dart';
import 'package:playflutter/core/model/entity/details.dart';
import 'package:playflutter/core/model/http/constants/api_constants.dart';
import 'package:playflutter/core/tools/log_tools.dart';
import 'package:playflutter/core/tools/paging/local_paging.dart';
import 'package:playflutter/core/tools/paging/paging.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/module/account/service/account_service.dart';
import 'package:playflutter/module/me/model/me_model.dart';
import 'package:playflutter/module/me/theme/theme_me.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 积分页面viewModel
class CoinViewModel extends BaseViewModel {
  final _model = MeModel();
  final viewStates = _CoinViewState();
  late AccountService accountService;
  late Paging<CoinRecord> paging;

  CoinViewModel(super.context);

  @override
  void init() {
    accountService = context.read<AccountService>();
    accountService.addListener(notifyListeners);
    paging = LocalPaging.build(
        notifier: this,
        localKey: context.userKey(ThemeMe.constants.coinList),
        createJson: (json) => CoinRecordPage.fromJson(json),
        initPage: 1);
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    accountService.removeListener(notifyListeners);
    paging.dispose();
    _model.dispose();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("Coin", "requestData - $status");

    // request coin list data.
    paging.requestData(status,
        (page) => _model.getCoinRecordAsync(page).then((value) => value.data));
  }
}

class _CoinViewState {
  var detailsData = DetailsData(
      title: ThemeMe.strings.coinHelpTitle, link: ApiConstants.URI_COIN_HELP);
}
