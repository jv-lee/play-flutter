import 'package:dio/dio.dart';
import 'package:playflutter/base/base_model.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/model/entity/data.dart';

/// @author jv.lee
/// @date 2022/6/29
/// @description 广场模块数据处理类
class SquareModel extends BaseModel {
  Future<ContentData> getSquareDataAsync(int page) async {
    return requestGet(
        path: "/user_article/list/$page/json",
        create: (resource) => ContentData.fromJson(resource));
  }

  /// 发布我分享的文章
  /// [title] 文章标题
  /// [link] 文章链接
  Future<Data> postShareDataSync(title, link) async {
    return requestPost(
        path: "/lg/user_article/add/json",
        create: (resource) => Data.fromJson(resource),
        data: FormData.fromMap({"title": title, "link": link}));
  }

  ///  删除我的分享文章
  ///  [id] 文章id
  Future<Data> postDeleteShareAsync(id) async {
    return requestPost(
        path: "/lg/user_article/delete/$id/json",
        create: (resource) => Data.fromJson(resource));
  }

  /// 我的分享列表
  /// [page] 分页页面 取值[1-40]
  Future<ContentData> getMyShareDataSync(page) async {
    return requestGet(
        path: "/user/lg/private_articles/$page/json",
        create: (resource) => ContentData.fromJson(resource));
  }
}
