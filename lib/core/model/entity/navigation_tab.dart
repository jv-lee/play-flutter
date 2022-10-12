import 'package:playflutter/core/extensions/json_extensions.dart';
import 'package:playflutter/core/model/entity/base/base_data.dart';
import 'package:playflutter/core/tools/paging/paging_data.dart';
import 'package:playflutter/core/widget/scroll/scroll_to_index.dart';

/// @author jv.lee
/// @date 2022/6/30
/// @description
class NavigationTabData extends BaseData with PagingData<NavigationTab> {
  NavigationTabData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final List<NavigationTab> data;
  late final int errorCode;
  late final String errorMsg;

  NavigationTabData.fromJson(Map<String, dynamic> json) {
    data = json.formatList('data', (json) => NavigationTab.fromJson(json));
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = this.data.map((e) => e.toJson()).toList();
    data['errorCode'] = errorCode;
    data['errorMsg'] = errorMsg;
    return data;
  }

  @override
  int responseCode() => errorCode;

  @override
  String responseMessage() => errorMsg;

  @override
  List<NavigationTab> getDataSource() => data;

  @override
  int getPageNumber() => 1;

  @override
  int getPageTotalNumber() => 1;
}

class NavigationTab extends ScrollToIndexBaseObject {
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
    final data = <String, dynamic>{};
    data['articles'] = articles.map((e) => e.toJson()).toList();
    data['cid'] = cid;
    data['name'] = name;
    return data;
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
    data['tags'] = tags;
    data['title'] = title;
    data['type'] = type;
    data['userId'] = userId;
    data['visible'] = visible;
    data['zan'] = zan;
    return data;
  }
}
