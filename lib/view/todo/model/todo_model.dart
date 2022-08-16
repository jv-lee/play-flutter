import 'package:dio/dio.dart';
import 'package:playflutter/base/base_model.dart';
import 'package:playflutter/model/entity/data.dart';
import 'package:playflutter/model/entity/todo.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description todo模块api接口
class TodoModel extends BaseModel {
  ///  新增一个TODO
  ///  [title] 新增标题（必须）
  ///  [content] 新增详情（必须）
  ///  [date] 2018-08-01 预定完成时间（不传默认当天，建议传）
  ///  [type] 工作:1、生活:2、娱乐:3 如果不设置type则为 0，未来无法做 type=0的筛选，会显示全部（筛选 type 必须为大于 0 的整数）（可选）
  ///  [priority] priority 主要用于定义优先级，在app 中预定义几个优先级：一般:0 重要:1（可选）
  Future<TodoData> postAddTodoAsync(
      title, content, date, type, priority) async {
    return requestPost(
        path: "/lg/todo/add/json",
        create: (resource) => TodoData.fromJson(resource),
        data: FormData.fromMap({
          "title": title,
          "content": content,
          "date": date,
          "type": type,
          "priority": priority
        }));
  }

  /// 删除一个TODO
  /// [id] todoID
  Future<Data> postDeleteTodoAsync(id) async {
    return requestPost(
        path: "/lg/todo/delete/$id/json",
        create: (resource) => Data.fromJson(resource));
  }

  ///  更新一个TODO
  ///  [id] todoID
  ///  [title] 新增标题（必须）
  ///  [content] 新增详情（必须）
  ///  [date] 2018-08-01 预定完成时间（不传默认当天，建议传）
  ///  [type] 工作:1、生活:2、娱乐:3 如果不设置type则为 0，未来无法做 type=0的筛选，会显示全部（筛选 type 必须为大于 0 的整数）（可选）
  ///  [priority] priority 主要用于定义优先级，在app 中预定义几个优先级：一般:0 重要:1（可选）
  ///  [status] 0为未完成，1为完成
  Future<TodoData> postUpdateTodoAsync(
      id, title, content, date, type, priority, status) async {
    return requestPost(
        path: "/lg/todo/update/$id/json",
        create: (resource) => TodoData.fromJson(resource),
        data: FormData.fromMap({
          "title": title,
          "content": content,
          "date": date,
          "type": type,
          "priority": priority,
          "status": status
        }));
  }

  /// 仅更新完成状态TODO
  /// [id] todoID
  /// [status] 0为未完成，1为完成
  Future<Data> postUpdateTodoStatusAsync(id, status) async {
    return requestPost(
        path: "/lg/todo/done/$id/json",
        create: (resource) => Data.fromJson(resource),
        data: FormData.fromMap({"status": status}));
  }

  /// 获取TODO列表
  ///  [page] 页码从1开始
  ///  [status] 状态， 1-完成；0未完成; 默认全部展示；
  ///  [type] 创建时传入的类型, 默认全部展示
  ///  [priority] 创建时传入的优先级；默认全部展示
  ///  [order] 1:完成日期顺序；2.完成日期逆序；3.创建日期顺序；4.创建日期逆序(默认)；
  Future<TodoPageData> postTodoDataAsync(page, type, status) async {
    return requestPost(
        path: "/lg/todo/v2/list/$page/json",
        create: (resource) => TodoPageData.fromJson(resource),
        data: FormData.fromMap({"type": type, "status": status}));
  }
}
