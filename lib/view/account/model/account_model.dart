import 'dart:io';

import 'package:dio/dio.dart';
import 'package:playflutter/entity/account.dart';
import 'package:playflutter/http/http_manager.dart';
import 'package:playflutter/theme/theme_constants.dart';

/// @author jv.lee
/// @date 2022/8/3
/// @description 账户相关请求
class AccountModel {
  Future<AccountData> getAccountInfoAsync() async {
    var response =
        await HttpManager.getInstance().dio.get("/user/lg/userinfo/json");
    if (response.statusCode == 200) {
      AccountData data = AccountData.fromJson(response.data);
      if (data.errorCode == ThemeConstants.REQUEST_OK) {
        return data;
      } else if (data.errorCode == ThemeConstants.REQUEST_TOKEN_ERROR) {
        throw const HttpException(ThemeConstants.REQUEST_TOKEN_ERROR_MESSAGE);
      } else {
        throw HttpException(data.errorMsg);
      }
    }
    throw HttpException(
        response.statusMessage ?? "getAccountInfoAsync http exception.");
  }

  Future<UserData> postLoginAsync(username, password) async {
    var response = await HttpManager.getInstance().dio.post("/user/login",
        data: FormData.fromMap({"username": username, "password": password}));
    if (response.statusCode == 200) {
      UserData data = UserData.fromJson(response.data);
      if (data.errorCode == ThemeConstants.REQUEST_OK) {
        return data;
      } else {
        throw HttpException(data.errorMsg);
      }
    }
    throw HttpException(
        response.statusMessage ?? "getLogoutAsync http exception.");
  }

  Future<UserData> postRegisterAsync(username, password, rePassword) async {
    var response = await HttpManager.getInstance().dio.post("/user/register",
        data: FormData.fromMap({
          "username": username,
          "password": password,
          "repassword": rePassword
        }));
    if (response.statusCode == 200) {
      UserData data = UserData.fromJson(response.data);
      if (data.errorCode == ThemeConstants.REQUEST_OK) {
        return data;
      } else {
        throw HttpException(data.errorMsg);
      }
    }
    throw HttpException(
        response.statusMessage ?? "getLogoutAsync http exception.");
  }

  Future<UserData> getLogoutAsync() async {
    var response = await HttpManager.getInstance().dio.get("/user/logout/json");
    if (response.statusCode == 200) {
      UserData data = UserData.fromJson(response.data);
      if (data.errorCode == ThemeConstants.REQUEST_OK) {
        return data;
      } else {
        throw HttpException(data.errorMsg);
      }
    }
    throw HttpException(
        response.statusMessage ?? "getLogoutAsync http exception.");
  }
}
