/// @author jv.lee
/// @date 2022/6/28
/// @description 数据实体转换扩展函数
import 'package:html/parser.dart';
import 'package:playflutter/entity/banner.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/entity/details.dart';
import 'package:playflutter/entity/navigation_tab.dart';
import 'package:playflutter/entity/parent_tab.dart';
import 'package:playflutter/tools/time_tools.dart';

extension BannerExtensions on BannerItem {
  DetailsData transformDetails() {
    return DetailsData(id: id.toString(), title: title, link: url.toString());
  }
}

extension ContentExtensions on Content {
  DetailsData transformDetails() {
    return DetailsData(
        id: id.toString(), title: getTitle(), link: link, isCollect: collect);
  }

  String getTitle() => parse(title).body.innerHtml;

  String getDescription() => parse(desc).body.innerHtml;

  String getAuthor() => author.isEmpty ? shareUser : author;

  String getDateFormat() => TimeTools.getChineseTimeMill(publishTime);

  String getCategory() {
    if (superChapterName.isNotEmpty && chapterName.isNotEmpty) {
      return "$superChapterName / $chapterName";
    } else if (superChapterName.isNotEmpty) {
      return superChapterName;
    } else if (chapterName.isNotEmpty) {
      return chapterName;
    } else {
      return "";
    }
  }
}

extension ParentTabExtensions on ParentTab {
  String formHtmlLabels() {
    return parse(_buildChildrenLabel()).body.innerHtml;
  }

  String _buildChildrenLabel() {
    var buffer = StringBuffer();
    for (var element in children) {
      buffer.write("${element.name}  ");
    }
    return buffer.toString();
  }
}

extension ArticlesExtensions on Articles {
  DetailsData transformDetails() {
    return DetailsData(
        id: id.toString(), title: getTitle(), link: link, isCollect: collect);
  }

  String getTitle() => parse(title).body.innerHtml;
}
