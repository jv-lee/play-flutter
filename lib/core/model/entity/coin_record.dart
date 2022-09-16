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
    final data = <String, dynamic>{};
    data['data'] = this.data.toJson();
    data['errorCode'] = errorCode;
    data['errorMsg'] = errorMsg;
    return data;
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
    final data = <String, dynamic>{};
    data['curPage'] = curPage;
    data['datas'] = datas.map((e) => e.toJson()).toList();
    data['offset'] = offset;
    data['over'] = over;
    data['pageCount'] = pageCount;
    data['size'] = size;
    data['total'] = total;
    return data;
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
    final data = <String, dynamic>{};
    data['coinCount'] = coinCount;
    data['date'] = date;
    data['desc'] = desc;
    data['id'] = id;
    data['reason'] = reason;
    data['type'] = type;
    data['userId'] = userId;
    data['userName'] = userName;
    return data;
  }
}
