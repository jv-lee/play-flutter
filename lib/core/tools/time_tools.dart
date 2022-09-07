// ignore_for_file: constant_identifier_names
/// @author jv.lee
/// @date 2022/6/24
/// @description 时间工具
class TimeTools {
  /// 分与毫秒的倍数
  static const int MIN = 60000;

  /// 时与毫秒的倍数
  static const int HOUR = 3600000;

  /// 天与毫秒的倍数
  static const int DAY = 86400000;

  static String getChineseTimeMill(int time) {
    int timeLong = DateTime.now().millisecondsSinceEpoch - time;
    if (timeLong < MIN) {
      return "刚刚";
    } else if (timeLong < HOUR) {
      return "${timeLong ~/ MIN}分钟前";
    } else if (timeLong < DAY) {
      return "${timeLong ~/ HOUR}小时前";
    } else if (timeLong < DAY * 7) {
      return "${timeLong ~/ DAY}天前";
    } else {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
      return "${date.month}-${date.day}";
    }
  }

  static String getCurrentFormatDate() {
    int time = DateTime.now().millisecondsSinceEpoch;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
    return "${date.year}-${date.month}-${date.day}";
  }
}
