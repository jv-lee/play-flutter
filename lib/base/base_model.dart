import 'dart:io';

import 'package:dio/dio.dart';
import 'package:playflutter/model/entity/base/base_data.dart';
import 'package:playflutter/model/http/http_manager.dart';

/// @author jv.lee
/// @date 2022/8/8
/// @description 所有model类基类
abstract class BaseModel {
  Future<T> requestGet<T extends BaseData>({
    required String path,
    required CreateEntity<T> create,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    var response = await HttpManager.getInstance().dio.get(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
    if (response.statusCode == 200) {
      T entity = create(response.data);
      if (entity.responseCode() == 0) {
        return entity;
      } else {
        throw HttpException(entity.responseMessage());
      }
    }
    throw HttpException(
        response.statusMessage ?? "request url:$path http exception.");
  }

  Future<T> requestPost<T extends BaseData>({
    required String path,
    required CreateEntity<T> create,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    var response = await HttpManager.getInstance().dio.post(path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
    if (response.statusCode == 200) {
      T entity = create(response.data);
      if (entity.responseCode() == 0) {
        return entity;
      } else {
        throw HttpException(entity.responseMessage());
      }
    }
    throw HttpException(
        response.statusMessage ?? "request url:$path http exception.");
  }
}

typedef CreateEntity<T> = T Function(dynamic resouse);
typedef RequestResult<T> = bool Function(T);
