import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/model/entity/coin_rank.dart';
import 'package:playflutter/core/tools/log_tools.dart';
import 'package:playflutter/core/tools/paging/paging.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/module/me/model/me_model.dart';
import 'package:playflutter/module/me/theme/theme_me.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 积分排行榜viewModel
class CoinRankViewModel extends BaseViewModel {
  final _meModel = MeModel();
  final viewStates = _CoinRankViewState();

  CoinRankViewModel(super.context);

  @override
  void init() {
    viewStates.paging = Paging.build(notifier: this, initPage: 1);
    requestData(LoadStatus.refresh);
  }

  @override
  void onCleared() {
    viewStates.paging.dispose();
    _meModel.dispose();
  }

  void requestData(LoadStatus status) async {
    LogTools.log("CoinRank", "requestData - $status");

    // request coinRank list data.
    viewStates.paging.requestData(
        status,
        (page) => _meModel
            .getCoinRankAsync(page)
            .then((value) => _swapRankList(value.data)));
  }

  /// 根据获取 当前排行榜的icon 1 2 3 名
  String findLevelIcon(CoinRank item) {
    return item.rank == "1"
        ? ThemeMe.images.rankNo1Svg
        : item.rank == "2"
            ? ThemeMe.images.rankNo2Svg
            : ThemeMe.images.rankNo3Svg;
  }

  /// 将排行榜前3名从列表移除重写填充到一个headerList列表中渲染头部
  CoinRankPage _swapRankList(CoinRankPage data) {
    if (data.curPage == 1) {
      List<CoinRank> list = [];
      for (int index = 0; index < 3; index++) {
        if (data.datas.isNotEmpty) {
          list.add(data.datas.removeAt(0));
        }
      }

      if (list.length >= 2) {
        //排行榜UI显示 0 —><- 1 位置数据对掉
        var item = list[0];
        list[0] = list[1];
        list[1] = item;
      }
      viewStates.headerList = list;
    }

    return data;
  }
}

class _CoinRankViewState {
  late Paging<CoinRank> paging;
  List<CoinRank> headerList = [];
}
