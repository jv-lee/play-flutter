import 'package:playflutter/base/base_model.dart';
import 'package:playflutter/model/entity/content.dart';
import 'package:playflutter/model/entity/tab.dart';

/// @author jv.lee
/// @date 2022/7/27
/// @description
class OfficialModel extends BaseModel {
  Future<TabData> getOfficialTabDataAsync() async {
    return requestGet(
        path: "/wxarticle/chapters/json",
        create: (resource) => TabData.fromJson(resource));
  }

  /// 获取公众号列表数据
  /// [id] 公众号TabId 由tab接口获取
  /// [page] 分页页面 取值[1-40]
  Future<ContentData> getOfficialListDataAsync(page, id) async {
    return requestGet(
        path: "/wxarticle/list/$id/$page/json",
        create: (resource) => ContentData.fromJson(resource));
  }
}
