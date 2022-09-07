import 'package:dio/dio.dart';
import 'package:playflutter/core/base/base_model.dart';
import 'package:playflutter/core/model/entity/coin_rank.dart';
import 'package:playflutter/core/model/entity/coin_record.dart';
import 'package:playflutter/core/model/entity/content.dart';
import 'package:playflutter/core/model/entity/data.dart';

/// @author jv.lee
/// @date 2022/8/5
/// @description
class MeModel extends BaseModel {
  /// 获取积分记录
  /// [page] 1 - *
  Future<CoinRecordData> getCoinRecordAsync(page) async {
    return requestGet(
        path: "/lg/coin/list/$page/json",
        create: (resource) => CoinRecordData.fromJson(resource));
  }

  /// 获取积分排行榜列表
  /// [page] 1 - *
  Future<CoinRankData> getCoinRankAsync(page) async {
    return requestGet(
        path: "/coin/rank/$page/json",
        create: (resource) => CoinRankData.fromJson(resource));
  }

  ///  收藏文章
  ///  [id] 文章id
  Future<Data> postCollectAsync(id) async {
    return requestPost(
        path: "/lg/collect/$id/json",
        create: (resource) => Data.fromJson(resource));
  }

  ///  取消收藏文章
  ///  [id] 文章id
  ///  [originId]
  Future<Data> postUnCollectAsync(id, originId) async {
    return requestPost(
        path: "/lg/uncollect/$id/json",
        create: (resource) => Data.fromJson(resource),
        data: FormData.fromMap({"originId": originId}));
  }

  /// 获取收藏记录
  /// [page] 0 - *
  Future<ContentData> getCollectListAsync(page) async {
    return requestGet(
        path: "/lg/collect/list/$page/json",
        create: (resource) => ContentData.fromJson(resource));
  }
}
