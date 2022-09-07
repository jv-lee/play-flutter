// ignore_for_file:  constant_identifier_names

/// @author jv.lee
/// @date 2022/7/18
/// @description 搜索历史数据库操作类
class SearchHistory {
  late String searchKey;
  late int time;

  SearchHistory({required this.searchKey, required this.time});

  static const TABLE_NAME = "SearchHistory";

  static const COLUMN_SEARCH_KEY = "searchKey";

  static const COLUMN_TIME = "time";

  static const CREATE_TABLE_SQL =
      "CREATE TABLE $TABLE_NAME ($COLUMN_SEARCH_KEY TEXT PRIMARY KEY,$COLUMN_TIME INTEGER)";

  Map<String, Object> toMap() {
    return <String, Object>{COLUMN_SEARCH_KEY: searchKey, COLUMN_TIME: time};
  }

  SearchHistory.fromMap(Map<String, dynamic> map) {
    searchKey = map[COLUMN_SEARCH_KEY];
    time = map[COLUMN_TIME];
  }

  static buildSearchHistory(String searchKey) {
    return SearchHistory(
        searchKey: searchKey, time: DateTime.now().microsecondsSinceEpoch);
  }
}
