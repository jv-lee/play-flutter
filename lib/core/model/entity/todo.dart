import 'package:playflutter/core/model/entity/base/base_data.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';

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

class TodoPage extends PagingData<Todo> {
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
  List<Todo> getDataSource() => datas;

  @override
  int getPageNumber() => curPage;

  @override
  int getPageTotalNumber() => pageCount;
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
    final data = <String, dynamic>{};
    data['completeDate'] = completeDate;
    data['completeDateStr'] = completeDateStr;
    data['content'] = content;
    data['date'] = date;
    data['dateStr'] = dateStr;
    data['id'] = id;
    data['priority'] = priority;
    data['status'] = status;
    data['title'] = title;
    data['type'] = type;
    data['userId'] = userId;
    return data;
  }
}
