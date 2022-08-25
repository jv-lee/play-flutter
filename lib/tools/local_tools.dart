import 'dart:convert';

import 'package:playflutter/extensions/function_extensions.dart';
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
      default:
        throw Exception("LocalTools.save<T> T is not found type.");
    }
  }

  static Future<T> get<T>(String key, {T? defaultValue}) async {
    final prefs = await SharedPreferences.getInstance();
    late T data;
    switch (T) {
      case String:
        data = (prefs.getString(key) ?? defaultValue ?? "") as T;
        break;
      case bool:
        data = (prefs.getBool(key) ?? defaultValue ?? false) as T;
        break;
      case int:
        data = (prefs.getInt(key) ?? defaultValue ?? 0) as T;
        break;
      case double:
        data = (prefs.getDouble(key) ?? defaultValue ?? 0) as T;
        break;
      default:
        throw Exception("LocalTools.get<T> T is not found type.");
    }
    return data;
  }

  static void remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
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
      {required String localKey,
      required CreateJson<T> createJson,
      required Future<T> requestFuture,
      required Function(T value) callback,
      required Function(dynamic error) onError}) async {
    // 本地缓存获取
    T? data = await localData(localKey, createJson);
    data?.run((self) => callback(self));

    // 网络请求
    requestFuture.then((value) {
      // 缓存网络数据
      localSave(localKey, value);
      callback(value);
    }).catchError(onError);
  }
}

typedef CreateJson<T> = T Function(Map<String, dynamic> json);
