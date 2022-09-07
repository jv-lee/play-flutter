import 'package:playflutter/core/model/entity/base/base_data.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';

/// @author jv.lee
/// @date 2022/8/8
/// @description 积分排行榜数据
class CoinRankData extends BaseData {
  CoinRankData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final CoinRankPage data;
  late final int errorCode;
  late final String errorMsg;

  CoinRankData.fromJson(Map<String, dynamic> json) {
    data = CoinRankPage.fromJson(json['data']);
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['errorCode'] = errorCode;
    _data['errorMsg'] = errorMsg;
    return _data;
  }

  @override
  int responseCode() => errorCode;

  @override
  String responseMessage() => errorMsg;
}

class CoinRankPage with PagingData<CoinRank> {
  CoinRankPage({
    required this.curPage,
    required this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  late final int curPage;
  late final List<CoinRank> datas;
  late final int offset;
  late final bool over;
  late final int pageCount;
  late final int size;
  late final int total;

  CoinRankPage.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    var dataJson = json['datas'];
    datas = dataJson == null
        ? []
        : List.from(dataJson).map((e) => CoinRank.fromJson(e)).toList();
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['curPage'] = curPage;
    _data['datas'] = datas.map((e) => e.toJson()).toList();
    _data['offset'] = offset;
    _data['over'] = over;
    _data['pageCount'] = pageCount;
    _data['size'] = size;
    _data['total'] = total;
    return _data;
  }

  @override
  List<CoinRank> getDataSource() => datas;

  @override
  int getPageNumber() => curPage;

  @override
  int getPageTotalNumber() => pageCount;
}

class CoinRank {
  CoinRank({
    required this.coinCount,
    required this.level,
    required this.nickname,
    required this.rank,
    required this.userId,
    required this.username,
  });

  late final int coinCount;
  late final int level;
  late final String nickname;
  late final String rank;
  late final int userId;
  late final String username;

  CoinRank.fromJson(Map<String, dynamic> json) {
    coinCount = json['coinCount'];
    level = json['level'];
    nickname = json['nickname'];
    rank = json['rank'];
    userId = json['userId'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coinCount'] = coinCount;
    _data['level'] = level;
    _data['nickname'] = nickname;
    _data['rank'] = rank;
    _data['userId'] = userId;
    _data['username'] = username;
    return _data;
  }
}
