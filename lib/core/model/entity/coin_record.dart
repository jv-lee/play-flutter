import 'package:playflutter/core/model/entity/base/base_data.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';

/// @author jv.lee
/// @date 2022/8/8
/// @description 个人积分记录
class CoinRecordData extends BaseData {
  CoinRecordData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final CoinRecordPage data;
  late final int errorCode;
  late final String errorMsg;

  CoinRecordData.fromJson(Map<String, dynamic> json) {
    data = CoinRecordPage.fromJson(json['data']);
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

class CoinRecordPage with PagingData<CoinRecord> {
  CoinRecordPage({
    required this.curPage,
    required this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  late final int curPage;
  late final List<CoinRecord> datas;
  late final int offset;
  late final bool over;
  late final int pageCount;
  late final int size;
  late final int total;

  CoinRecordPage.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    var dataJson = json['datas'];
    datas = dataJson == null
        ? []
        : List.from(dataJson).map((e) => CoinRecord.fromJson(e)).toList();
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
  List<CoinRecord> getDataSource() => datas;

  @override
  int getPageNumber() => curPage;

  @override
  int getPageTotalNumber() => pageCount;
}

class CoinRecord {
  CoinRecord({
    required this.coinCount,
    required this.date,
    required this.desc,
    required this.id,
    required this.reason,
    required this.type,
    required this.userId,
    required this.userName,
  });

  late final int coinCount;
  late final int date;
  late final String desc;
  late final int id;
  late final String reason;
  late final int type;
  late final int userId;
  late final String userName;

  CoinRecord.fromJson(Map<String, dynamic> json) {
    coinCount = json['coinCount'];
    date = json['date'];
    desc = json['desc'];
    id = json['id'];
    reason = json['reason'];
    type = json['type'];
    userId = json['userId'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coinCount'] = coinCount;
    _data['date'] = date;
    _data['desc'] = desc;
    _data['id'] = id;
    _data['reason'] = reason;
    _data['type'] = type;
    _data['userId'] = userId;
    _data['userName'] = userName;
    return _data;
  }
}
