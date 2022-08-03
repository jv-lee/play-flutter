import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// @author jv.lee
/// @date 2022/7/29
/// @description 本地缓存工具类
class LocalTools {
  static void save<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();
    switch (T) {
      case String:
        prefs.setString(key, value as String);
        break;
      case bool:
        prefs.setBool(key, value as bool);
        break;
      case int:
        prefs.setInt(key, value as int);
        break;
      case double:
        prefs.setDouble(key, value as double);
        break;
    }
  }

  static Future<T?> get<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    T? data;
    switch (T) {
      case String:
        data = prefs.getString(key) as T?;
        break;
      case bool:
        data = prefs.getBool(key) as T?;
        break;
      case int:
        data = prefs.getInt(key) as T?;
        break;
      case double:
        data = prefs.getDouble(key) as T?;
        break;
    }
    return data;
  }

  static void localSave<T>(String localKey, T? data) async {
    final prefs = await SharedPreferences.getInstance();
    if (data == null) {
      prefs.remove(localKey);
    } else {
      prefs.setString(localKey, jsonEncode(data));
    }
  }

  static Future<T?> localData<T>(
      String localKey, CreateJson<T> createJson) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(localKey);
    if (jsonStr != null && jsonStr.isNotEmpty) {
      return createJson(jsonDecode(jsonStr));
    }
    return null;
  }

  static void localRequest<T>(
      String localKey,
      CreateJson<T> createJson,
      Future<T> requestFuture,
      Function(T value) callback,
      Function(dynamic error) onError) async {
    // 本地缓存获取
    T? data = await localData(localKey, createJson);
    if (data != null) {
      callback(data);
    }

    // 网络请求
    requestFuture.then((value) {
      // 缓存网络数据
      localSave(localKey, value);
      callback(value);
    }).catchError(onError);
  }
}

typedef CreateJson<T> = T Function(Map<String, dynamic> json);
