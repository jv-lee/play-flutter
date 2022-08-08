import 'package:dio/dio.dart';
import 'package:playflutter/base/base_model.dart';
import 'package:playflutter/model/entity/account.dart';

/// @author jv.lee
/// @date 2022/8/3
/// @description 账户相关请求
class AccountModel extends BaseModel {
  Future<AccountData> getAccountInfoAsync() async {
    return requestGet(
        path: "/user/lg/userinfo/json",
        create: (resource) => AccountData.fromJson(resource));
  }

  Future<UserData> postLoginAsync(username, password) async {
    return requestPost<UserData>(
        path: "/user/login",
        create: (resource) => UserData.fromJson(resource),
        data: FormData.fromMap({"username": username, "password": password}));
  }

  Future<UserData> postRegisterAsync(username, password, rePassword) async {
    return requestPost<UserData>(
        path: "/user/register",
        create: (resource) => UserData.fromJson(resource),
        data: FormData.fromMap({
          "username": username,
          "password": password,
          "repassword": rePassword
        }));
  }

  Future<UserData> getLogoutAsync() async {
    return requestGet(
        path: "/user/logout/json",
        create: (resource) => UserData.fromJson(resource));
  }
}
