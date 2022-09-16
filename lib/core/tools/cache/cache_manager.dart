import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// @author jv.lee
/// @date 2022/9/1
/// @description
class CacheManager {
  CacheManager._internal();

  static final CacheManager _instance = CacheManager._internal();

  static CacheManager getInstance() => _instance;

  late Directory cacheDirectory;

  void init() {
    getTemporaryDirectory().then((value) {
      var cacheDirectory = Directory("${value.path}/app_cache");
      if (!cacheDirectory.existsSync()) cacheDirectory.createSync();
      this.cacheDirectory = cacheDirectory;
    });
  }

  Future<File> createFile(name) async {
    var file = File("${cacheDirectory.path}/$name");
    if (!file.existsSync()) file.createSync();
    return file;
  }

  Future<void> removeFile(name) async {
    try {
      var file = await cacheDirectory
          .list()
          .firstWhere((element) => element.path.contains(name));
      file.deleteSync();
      // ignore: empty_catches
    } catch (e){}
  }

  Future<File?> getFile(name) async {
    try {
      var file = await cacheDirectory
          .list()
          .firstWhere((element) => element.path.contains(name));
      return File(file.path);
    } catch (e) {
      return null;
    }
  }
}

final CacheManager cacheManager = CacheManager.getInstance();
