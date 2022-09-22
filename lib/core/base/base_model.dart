import 'dart:io';

import 'package:dio/dio.dart';
import 'package:playflutter/core/model/entity/base/base_data.dart';
import 'package:playflutter/core/model/http/constants/api_constants.dart';
import 'package:playflutter/core/model/http/http_manager.dart';

/// @author jv.lee
/// @date 2022/8/8
/// @description 所有model类基类
abstract class BaseModel {
  late Dio dio;
  CancelToken token = CancelToken();

  /// 子类如需替换域名地址可以在构造函数中创建新的dio替换
  ///   ChildModel() {
  ///     super.dio = HttpManager.createDio(baseUri);
  ///   }
  BaseModel({Dio? dio}) {
    this.dio = dio ?? httpManager.dio;
  }

  /// 页面销毁时调用dispose取消所有请求
  void dispose() {
    token.cancel("page destroy,cancel request.");
  }

  Future<T> requestGet<T extends BaseData>({
    required String path,
    required CreateEntity<T> create,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    var response = await dio.get(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken ?? token,
        onReceiveProgress: onReceiveProgress);
    if (response.statusCode == 200) {
      T entity = create(response.data);
      if (entity.responseIsSuccess()) {
        return entity;
      } else if (entity.responseCode() == ApiConstants.REQUEST_TOKEN_ERROR) {
        throw const HttpException(ApiConstants.REQUEST_TOKEN_ERROR_MESSAGE);
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
    var response = await dio.post(path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken ?? token,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
    if (response.statusCode == 200) {
      T entity = create(response.data);
      if (entity.responseIsSuccess()) {
        return entity;
      } else if (entity.responseCode() == ApiConstants.REQUEST_TOKEN_ERROR) {
        throw const HttpException(ApiConstants.REQUEST_TOKEN_ERROR_MESSAGE);
      } else {
        throw HttpException(entity.responseMessage());
      }
    }
    throw HttpException(
        response.statusMessage ?? "request url:$path http exception.");
  }
}

/// 通过数据实体构建转换函数 Entity.fromJson(resource)
typedef CreateEntity<T> = T Function(dynamic resource);
