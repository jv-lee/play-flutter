import 'package:playflutter/tools/paging/paging_data.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class NavigationTabData extends PagingData<NavigationTab> {
  NavigationTabData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final List<NavigationTab> data;
  late final int errorCode;
  late final String errorMsg;

  NavigationTabData.fromJson(Map<String, dynamic> json) {
    data =
        List.from(json['data']).map((e) => NavigationTab.fromJson(e)).toList();
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['errorCode'] = errorCode;
    _data['errorMsg'] = errorMsg;
    return _data;
  }

  @override
  List<NavigationTab> getDataSource() => data;

  @override
  int getPageNumber() => 1;

  @override
  int getPageTotalNumber() => 1;
}

class NavigationTab {
  NavigationTab({
    required this.articles,
    required this.cid,
    required this.name,
  });

  late final List<Articles> articles;
  late final int cid;
  late final String name;

  NavigationTab.fromJson(Map<String, dynamic> json) {
    articles =
        List.from(json['articles']).map((e) => Articles.fromJson(e)).toList();
    cid = json['cid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['articles'] = articles.map((e) => e.toJson()).toList();
    _data['cid'] = cid;
    _data['name'] = name;
    return _data;
  }
}

class Articles {
  Articles({
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
    required this.link,
    required this.niceDate,
    required this.niceShareDate,
    required this.origin,
    required this.prefix,
    required this.projectLink,
    required this.publishTime,
    required this.realSuperChapterId,
    required this.selfVisible,
    this.shareDate,
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
  late final String link;
  late final String niceDate;
  late final String niceShareDate;
  late final String origin;
  late final String prefix;
  late final String projectLink;
  late final int publishTime;
  late final int realSuperChapterId;
  late final int selfVisible;
  late final int? shareDate;
  late final String shareUser;
  late final int superChapterId;
  late final String superChapterName;
  late final List<dynamic> tags;
  late final String title;
  late final int type;
  late final int userId;
  late final int visible;
  late final int zan;

  Articles.fromJson(Map<String, dynamic> json) {
    apkLink = json['apkLink'];
    audit = json['audit'];
    author = json['author'];
    canEdit = json['canEdit'];
    chapterId = json['chapterId'];
    chapterName = json['chapterName'];
    collect = json['collect'];
    courseId = json['courseId'];
    desc = json['desc'];
    descMd = json['descMd'];
    envelopePic = json['envelopePic'];
    fresh = json['fresh'];
    host = json['host'];
    id = json['id'];
    link = json['link'];
    niceDate = json['niceDate'];
    niceShareDate = json['niceShareDate'];
    origin = json['origin'];
    prefix = json['prefix'];
    projectLink = json['projectLink'];
    publishTime = json['publishTime'];
    realSuperChapterId = json['realSuperChapterId'];
    selfVisible = json['selfVisible'];
    shareDate = json['shareDate'];
    shareUser = json['shareUser'];
    superChapterId = json['superChapterId'];
    superChapterName = json['superChapterName'];
    tags = List.castFrom<dynamic, dynamic>(json['tags']);
    title = json['title'];
    type = json['type'];
    userId = json['userId'];
    visible = json['visible'];
    zan = json['zan'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['apkLink'] = apkLink;
    _data['audit'] = audit;
    _data['author'] = author;
    _data['canEdit'] = canEdit;
    _data['chapterId'] = chapterId;
    _data['chapterName'] = chapterName;
    _data['collect'] = collect;
    _data['courseId'] = courseId;
    _data['desc'] = desc;
    _data['descMd'] = descMd;
    _data['envelopePic'] = envelopePic;
    _data['fresh'] = fresh;
    _data['host'] = host;
    _data['id'] = id;
    _data['link'] = link;
    _data['niceDate'] = niceDate;
    _data['niceShareDate'] = niceShareDate;
    _data['origin'] = origin;
    _data['prefix'] = prefix;
    _data['projectLink'] = projectLink;
    _data['publishTime'] = publishTime;
    _data['realSuperChapterId'] = realSuperChapterId;
    _data['selfVisible'] = selfVisible;
    _data['shareDate'] = shareDate;
    _data['shareUser'] = shareUser;
    _data['superChapterId'] = superChapterId;
    _data['superChapterName'] = superChapterName;
    _data['tags'] = tags;
    _data['title'] = title;
    _data['type'] = type;
    _data['userId'] = userId;
    _data['visible'] = visible;
    _data['zan'] = zan;
    return _data;
  }
}
