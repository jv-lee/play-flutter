import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/model/entity/coin_rank.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/tools/paging/paging.dart';
import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/view/me/model/me_model.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 积分排行榜viewModel
class CoinRankViewModel extends BaseViewModel {
  final _model = MeModel();
  final viewStates = _CoinRankViewState();
  late Paging<CoinRank> paging;

  CoinRankViewModel(super.context);

  @override
  void init() {
    paging = Paging.build(notifier: this, initPage: 1);
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
    paging.requestData(
        status,
        (page) => _model
            .getCoinRankAsync(page)
            .then((value) => _swapRankList(value.data)));
  }

  /// 根据获取 当前排行榜的icon 1 2 3 名
  String findLevelIcon(CoinRank item) {
    return item.rank == "1"
        ? ThemeImages.meRankNo1Svg
        : item.rank == "2"
            ? ThemeImages.meRankNo2Svg
            : ThemeImages.meRankNo3Svg;
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
  List<CoinRank> headerList = [];
}
