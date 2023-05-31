import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_module_service.dart';
import 'package:playflutter/core/extensions/exception_extensions.dart';
import 'package:playflutter/core/model/entity/account.dart';
import 'package:playflutter/core/model/http/constants/api_constants.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/tools/cache/preferences.dart';
import 'package:playflutter/core/widget/dialog/loading_dialog.dart';
import 'package:playflutter/module/account/model/account_model.dart';
import 'package:playflutter/module/account/theme/theme_account.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/8/3
/// @description 账户服务，应用存活期间常驻，全模块可调用账户服务
class AccountService extends BaseModuleService {
  final _accountModel = AccountModel();
  final viewStates = AccountViewState();

  AccountService(super.context);

  @override
  void init() {}

  /// 请求账户信息，更新全局账户状态
  void requestAccountData(Function callback) async {
    _accountModel.getAccountInfoAsync().then((value) {
      updateAccountStatus(value, true);
    }).catchError((error) async {
      // 登陆token失效
      if (error is HttpException &&
          error.message == ApiConstants.REQUEST_TOKEN_ERROR_MESSAGE) {
        updateAccountStatus(null, false);
        return;
      }
      // 获取本地数据
      var localAccount = await Preferences.getCache(
          ThemeAccount.constants.accountData,
          (json) => AccountData.fromJson(json));
      updateAccountStatus(localAccount, localAccount != null);
    }).whenComplete(() => callback());
  }

  /// 请求登出
  void requestLogout(BuildContext context) {
    // 显示loading弹窗
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingDialog());

    _accountModel.getLogoutAsync().then((value) {
      updateAccountStatus(null, false);
      Toast.show(ThemeAccount.strings.logoutSuccess);
    }).catchError((onError) {
      onFailedToast(onError);
    }).whenComplete(() => Navigator.pop(context));
  }

  /// 更新当前账户状态信息
  void updateAccountStatus(AccountData? accountData, bool isLogin) {
    Preferences.saveCache(ThemeAccount.constants.accountData, accountData);
    Preferences.save(ThemeCommon.constants.isLogin, isLogin);
    viewStates.accountData = accountData;
    viewStates.isLogin = isLogin;
    notifyListeners();
  }
}

class AccountViewState {
  AccountData? accountData;
  bool isLogin = false;

  int get userId => accountData?.data.userInfo.id ?? 0;

  int get coinCount => accountData?.data.userInfo.coinCount ?? 0;

  int get level => accountData?.data.coinInfo.level ?? 0;

  String get rank => accountData?.data.coinInfo.rank ?? "0";

  String get nickname => accountData?.data.userInfo.nickname ?? "";
}

extension AccountContextExtensions on BuildContext {
  String userKey(String key) {
    return "$key${read<AccountService>().viewStates.userId}";
  }
}
