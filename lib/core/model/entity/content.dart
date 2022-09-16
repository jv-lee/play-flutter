import 'package:playflutter/core/model/entity/base/base_data.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';

/// @author jv.lee
/// @date 2022/6/27
/// @description 项目通用内容实体
class ContentData extends BaseData {
  ContentData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final ContentDataPage data;
  late final int errorCode;
  late final String errorMsg;

  ContentData.fromJson(Map<String, dynamic> json) {
    data = ContentDataPage.fromJson(json['data']);
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

class ContentDataPage extends PagingData<Content> {
  ContentDataPage({
    required this.curPage,
    required this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  late final int curPage;
  late final List<Content> datas;
  late final int offset;
  late final bool over;
  late final int pageCount;
  late final int size;
  late final int total;

  ContentDataPage.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    var dataJson = json['datas'];
    datas = dataJson == null
        ? []
        : List.from(dataJson).map((e) => Content.fromJson(e)).toList();
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
  List<Content> getDataSource() {
    return datas;
  }

  @override
  int getPageNumber() {
    return curPage;
  }

  @override
  int getPageTotalNumber() {
    return pageCount;
  }
}

class Content {
  Content({
    required this.apkLink,
    required this.audit,
    required this.author,
    required this.canEdit,
    required this.chapterId,
    required this.chapterName,
    required this.collect,
    required this.courseId,
    required this.desc,
    required this.descMd,
    required this.envelopePic,
    required this.fresh,
    required this.host,
    required this.id,
    required this.originId,
    required this.link,
    required this.niceDate,
    required this.niceShareDate,
    required this.origin,
    required this.prefix,
    required this.projectLink,
    required this.publishTime,
    required this.realSuperChapterId,
    required this.selfVisible,
    required this.shareDate,
    required this.shareUser,
    required this.superChapterId,
    required this.superChapterName,
    required this.tags,
    required this.title,
    required this.type,
    required this.userId,
    required this.visible,
    required this.zan,
  });

  late final String apkLink;
  late final int audit;
  late final String author;
  late final bool canEdit;
  late final int chapterId;
  late final String chapterName;
  late final bool collect;
  late final int courseId;
  late final String desc;
  late final String descMd;
  late final String envelopePic;
  late final bool fresh;
  late final String host;
  late final int id;
  late final int originId;
  late final String link;
  late final String niceDate;
  late final String niceShareDate;
  late final String origin;
  late final String prefix;
  late final String projectLink;
  late final int publishTime;
  late final int realSuperChapterId;
  late final int selfVisible;
  late final int shareDate;
  late final String shareUser;
  late final int superChapterId;
  late final String superChapterName;
  late final List<Tags> tags;
  late final String title;
  late final int type;
  late final int userId;
  late final int visible;
  late final int zan;

  Content.fromJson(Map<String, dynamic> json) {
    apkLink = json['apkLink'] ?? "";
    audit = json['audit'] ?? 0;
    author = json['author'] ?? "";
    canEdit = json['canEdit'] ?? false;
    chapterId = json['chapterId'] ?? 0;
    chapterName = json['chapterName'] ?? "";
    collect = json['collect'] ?? false;
    courseId = json['courseId'] ?? 0;
    desc = json['desc'] ?? "";
    descMd = json['descMd'] ?? "";
    envelopePic = json['envelopePic'] ?? "";
    fresh = json['fresh'] ?? false;
    host = json['host'] ?? "";
    id = json['id'] ?? 0;
    originId = json['originId'] ?? 0;
    link = json['link'] ?? "";
    niceDate = json['niceDate'] ?? "";
    niceShareDate = json['niceShareDate'] ?? "";
    origin = json['origin'] ?? "";
    prefix = json['prefix'] ?? "";
    projectLink = json['projectLink'] ?? "";
    publishTime = json['publishTime'] ?? 0;
    realSuperChapterId = json['realSuperChapterId'] ?? 0;
    selfVisible = json['selfVisible'] ?? 0;
    shareDate = json['shareDate'] ?? 0;
    shareUser = json['shareUser'] ?? "";
    superChapterId = json['superChapterId'] ?? 0;
    superChapterName = json['superChapterName'] ?? "";
    var tagsJson = json['tags'];
    tags = tagsJson == null
        ? []
        : List.from(tagsJson).map((e) => Tags.fromJson(e)).toList();
    title = json['title'] ?? "";
    type = json['type'] ?? 0;
    userId = json['userId'] ?? 0;
    visible = json['visible'] ?? 0;
    zan = json['zan'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['apkLink'] = apkLink;
    data['audit'] = audit;
    data['author'] = author;
    data['canEdit'] = canEdit;
    data['chapterId'] = chapterId;
    data['chapterName'] = chapterName;
    data['collect'] = collect;
    data['courseId'] = courseId;
    data['desc'] = desc;
    data['descMd'] = descMd;
    data['envelopePic'] = envelopePic;
    data['fresh'] = fresh;
    data['host'] = host;
    data['id'] = id;
    data['originId'] = originId;
    data['link'] = link;
    data['niceDate'] = niceDate;
    data['niceShareDate'] = niceShareDate;
    data['origin'] = origin;
    data['prefix'] = prefix;
    data['projectLink'] = projectLink;
    data['publishTime'] = publishTime;
    data['realSuperChapterId'] = realSuperChapterId;
    data['selfVisible'] = selfVisible;
    data['shareDate'] = shareDate;
    data['shareUser'] = shareUser;
    data['superChapterId'] = superChapterId;
    data['superChapterName'] = superChapterName;
    data['tags'] = tags.map((e) => e.toJson()).toList();
    data['title'] = title;
    data['type'] = type;
    data['userId'] = userId;
    data['visible'] = visible;
    data['zan'] = zan;
    return data;
  }
}

class Tags {
  Tags({
    required this.name,
    required this.url,
  });

  late final String name;
  late final String url;

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
