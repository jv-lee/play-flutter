import 'package:path/path.dart';
import 'package:playflutter/model/db/entity/search_history.dart';
import 'package:sqflite/sqflite.dart';

/// @author jv.lee
/// @date 2022/7/18
/// @description 数据库管理类
class DatabaseManager {
  DatabaseManager._internal();

  static final DatabaseManager _instance = DatabaseManager._internal();

  static DatabaseManager getInstance() {
    return _instance;
  }

  final String _databaseName = "play-flutter.db";
  final int _databaseVersion = 1;

  Database? _database;

  init() async {
    if (_database != null) return;
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);
    _database = await openDatabase(path, version: _databaseVersion,
        onCreate: (Database db, int version) async {
      // 创建搜索历史记录表
      await db.execute(SearchHistory.CREATE_TABLE_SQL);
    });
  }

  Database getDatabase() {
    if (_database == null) throw Exception("DatabaseManager not init()");
    return _database!;
  }
}
