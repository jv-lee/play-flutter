// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:playflutter/extensions/function_extensions.dart';
import 'package:playflutter/tools/cache/cache_functions.dart';
import 'package:playflutter/tools/cache/cache_manager.dart';

/// @author jv.lee
/// @date 2022/8/31
/// @description 缓存工具类，缓存业务数据（该数据支持清除,项目networkImage共用该缓存文件位置）
/// 该工具获取数据与Preferences效率对比
/// 以主页banner数据为例 首次加载
/// Preferences 155ms
/// CacheTools 232ms
class CacheTools {
  static Future<bool> saveCache<T>(String localKey, T? data) async {
    if (data == null) {
      cacheManager.removeFile(localKey);
      return false;
    } else {
      var jsonData = jsonEncode(data);
      var file = await cacheManager.createFile(localKey);
      await file.writeAsString(jsonData);
      return true;
    }
  }

  static Future<T?> getCache<T>(
      String localKey, CreateJson<T> createJson) async {
    File? file = await cacheManager.getFile(localKey);

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
