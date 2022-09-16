import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// 文件管理类
class FileTools {
  /// 获取缓存
  static Future<double> loadApplicationCache() async {
    try {
      // data/data/package/files
      // Directory filesDirectory = await getApplicationSupportDirectory();
      // data/data/package/cache
      Directory cacheDirectory = await getTemporaryDirectory();

      // 获取缓存大小
      double value = await getTotalSizeOfFilesInDir(cacheDirectory);
      return value;
    } catch (e) {
      return 0;
    }
  }

  /// 清除缓存
  static Future<void> clearApplicationCache() async {
    // data/data/package/cache
    Directory cacheDirectory = await getTemporaryDirectory();

    await delDir(cacheDirectory);
  }

  /// 循环计算文件的大小（递归）
  static Future<double> getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      if (children.isNotEmpty) {
        for (final FileSystemEntity child in children) {
          total += await getTotalSizeOfFilesInDir(child);
        }
      }
      return total;
    }
    return 0;
  }

  /// 缓存大小格式转换
  static String formatSize(double value) {
    List<String> unitArr = ['B', 'K', 'M', 'G'];
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  /*
  *
  * 删除缓存
  * 参数：Directory directory = await getApplicationDocumentsDirectory();
  * */
  static Future<void> delDir(FileSystemEntity file) async {
    if (file is Directory && file.existsSync()) {
      final List<FileSystemEntity> children =
          file.listSync(recursive: true, followLinks: true);
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    try {
      if (file.existsSync()) {
        await file.delete(recursive: true);
      }
      // ignore: empty_catches
    } catch (err) {}
  }
}
