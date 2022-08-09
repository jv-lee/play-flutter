import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/model/entity/coin_rank.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/me/model/me_model.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 积分排行榜viewModel
class CoinRankViewModel extends BaseViewModel{
  final _model = MeModel();
  late Paging<CoinRank> paging;

  CoinRankViewModel(super.context);

  @override
  void init() {
    paging = Paging.build(notifier: this);
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    paging.dispose();
    _model.dispose();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("CoinRank", "requestData - $status");

    // request coinRank list data.
    paging.requestData(status,
            (page) => _model.getCoinRankAsync(page).then((value) => value.data));
  }
}