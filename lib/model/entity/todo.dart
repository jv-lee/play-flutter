import 'package:playflutter/model/entity/base/base_data.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description todo网络数据实体
class TodoData extends BaseData {
  TodoData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final Todo data;
  late final int errorCode;
  late final String errorMsg;

  TodoData.fromJson(Map<String, dynamic> json) {
    data = Todo.fromJson(json['data']);
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

class TodoPageData extends BaseData {
  TodoPageData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final TodoPage data;
  late final int errorCode;
  late final String errorMsg;

  TodoPageData.fromJson(Map<String, dynamic> json) {
    data = TodoPage.fromJson(json['data']);
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

class TodoPage {
  TodoPage({
    required this.curPage,
    required this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  late final int curPage;
  late final List<Todo> datas;
  late final int offset;
  late final bool over;
  late final int pageCount;
  late final int size;
  late final int total;

  TodoPage.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    var dataJson = json['datas'];
    datas = dataJson == null
        ? []
        : List.from(dataJson).map((e) => Todo.fromJson(e)).toList();
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
}

class Todo {
  Todo({
    this.completeDate,
    required this.completeDateStr,
    required this.content,
    required this.date,
    required this.dateStr,
    required this.id,
    required this.priority,
    required this.status,
    required this.title,
    required this.type,
    required this.userId,
  });

  late final int? completeDate;
  late final String completeDateStr;
  late final String content;
  late final int date;
  late final String dateStr;
  late final int id;
  late final int priority;
  late final int status;
  late final String title;
  late final int type;
  late final int userId;

  Todo.fromJson(Map<String, dynamic> json) {
    completeDate = json['completeDate'];
    completeDateStr = json['completeDateStr'];
    content = json['content'];
    date = json['date'];
    dateStr = json['dateStr'];
    id = json['id'];
    priority = json['priority'];
    status = json['status'];
    title = json['title'];
    type = json['type'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['completeDate'] = completeDate;
    _data['completeDateStr'] = completeDateStr;
    _data['content'] = content;
    _data['date'] = date;
    _data['dateStr'] = dateStr;
    _data['id'] = id;
    _data['priority'] = priority;
    _data['status'] = status;
    _data['title'] = title;
    _data['type'] = type;
    _data['userId'] = userId;
    return _data;
  }
}
