/// @author jv.lee
/// @date 2022/7/29
/// @description 网络数据缓存获取方式
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void localRequest<T>(
    String localKey,
    CreateJson<T> createJson,
    Future<T> future,
    Function(T value) callback,
    Function(dynamic error) onError) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonStr = prefs.getString(localKey);
  T? localValue;

  // 本地缓存获取
  if (jsonStr != null) {
    localValue = createJson(jsonDecode(jsonStr));
    callback(localValue as T);
  }

  // 网络请求
  future.then((value) {
    prefs.setString(localKey, jsonEncode(value));
    callback(value);
  }).catchError(onError);
}

typedef CreateJson<T> = T Function(Map<String, dynamic> json);