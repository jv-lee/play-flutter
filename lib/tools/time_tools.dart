import 'package:flustars/flustars.dart';

/// @author jv.lee
/// @date 2022/6/24
/// @description
// ignore_for_file: constant_identifier_names

class TimeTools {
  /// 分与毫秒的倍数
  static const int MIN = 60000;

  /// 时与毫秒的倍数
  static const int HOUR = 3600000;

  /// 天与毫秒的倍数
  static const int DAY = 86400000;

  static String getChineseTimeMill(int time) {
    int timeLong = DateTime.now().microsecondsSinceEpoch - time;
    if (timeLong < MIN) {
      return "刚刚";
    } else if (timeLong < HOUR) {
      return "${timeLong / MIN}分钟前";
    } else if (timeLong < DAY) {
      return "${timeLong / HOUR}小时前";
    } else if (timeLong < DAY * 7) {
      return "${timeLong / DAY}天前";
    } else {
      return DateUtil.formatDateMs(time, format: DateFormats.mo_d);
    }
  }
}
