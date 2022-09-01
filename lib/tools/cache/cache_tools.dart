// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:playflutter/extensions/function_extensions.dart';
import 'package:playflutter/tools/cache/cache_functions.dart';

/// @author jv.lee
/// @date 2022/8/31
/// @description 缓存工具类，缓存业务数据（该数据支持清除,项目networkImage共用该缓存文件位置）
class CacheTools {
  static Future<bool> saveCache<T>(String localKey, T? data) async {
    final cacheManager = DefaultCacheManager();
    if (data == null) {
      cacheManager.removeFile(localKey);
      return false;
    } else {
      var jsonData = jsonEncode(data);
      var tempFile = await cacheManager.store.fileSystem.createFile(localKey);
      var file = await tempFile.writeAsString(jsonData);
      await cacheManager.putFile(localKey, file.readAsBytesSync());
      await tempFile.delete();
      return true;
    }
  }

  static Future<T?> getCache<T>(
      String localKey, CreateJson<T> createJson) async {
    final cacheManager = DefaultCacheManager();
    File? file = (await cacheManager.store.getFile(localKey))?.file;

    if (file != null) {
      final jsonStr = await file.readAsString();

      if (jsonStr.isNotEmpty) {
        return createJson(jsonDecode(jsonStr));
      }
    }
    return null;
  }

  static void requestCache<T>(
      {required String localKey,
      required CreateJson<T> createJson,
      required Future<T> requestFuture,
      required Function(T value) callback,
      required Function(dynamic error) onError}) async {
    // 本地缓存获取
    T? data = await getCache(localKey, createJson);
    data?.run((self) => callback(self));

    // 网络请求
    requestFuture.then((value) {
      // 缓存网络数据
      saveCache(localKey, value);
      callback(value);
    }).catchError(onError);
  }

}
