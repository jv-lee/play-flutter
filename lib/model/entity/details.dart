// ignore_for_file: constant_identifier_names
/// @author jv.lee
/// @date 2022/6/28
/// @description 内容详情页数据封装类
class DetailsData {
  late final String id;
  late final String title;
  late final String link;
  late final bool isCollect;

  DetailsData(
      {this.id = empty_id,
      required this.title,
      required this.link,
      this.isCollect = false});

  static const String empty_id = "0";
}
