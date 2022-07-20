import 'package:playflutter/db/database_manager.dart';
import 'package:playflutter/db/entity/search_history.dart';
import 'package:sqflite/sqflite.dart';

/// @author jv.lee
/// @date 2022/7/19
/// @description 搜索历史记录数据库操作类
class SearchHistoryDao {
  final Database _database = DatabaseManager.getInstance().getDatabase();

  Future<SearchHistory> insert(SearchHistory searchHistory) async {
    await _database.insert(SearchHistory.TABLE_NAME, searchHistory.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return searchHistory;
  }

  Future<int> delete(String searchKey) async {
    return await _database.delete(SearchHistory.TABLE_NAME,
        where: "${SearchHistory.COLUMN_SEARCH_KEY} = ?",
        whereArgs: [searchKey]);
  }

  Future<int> deleteAll() async {
    return await _database.delete(SearchHistory.TABLE_NAME);
  }

  Future<int> update(SearchHistory searchHistory) async {
    return await _database.update(
        SearchHistory.TABLE_NAME, searchHistory.toMap(),
        where: "${SearchHistory.COLUMN_SEARCH_KEY} = ?",
        whereArgs: [searchHistory.searchKey]);
  }

  Future<List<SearchHistory>> queryAll() async {
    //  ORDER BY search_history_time DESC LIMIT 0,5
    List<Map<String, dynamic>> history = await _database.query(
        SearchHistory.TABLE_NAME,
        orderBy: "${SearchHistory.COLUMN_TIME} DESC",
        limit: 5);
    return List.generate(history.length, (index) {
      return SearchHistory(
          searchKey: history[index][SearchHistory.COLUMN_SEARCH_KEY],
          time: history[index][SearchHistory.COLUMN_TIME]);
    });
  }
}
