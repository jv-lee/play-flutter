import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/base/base_module_service.dart';
import 'package:playflutter/extensions/exception_extensions.dart';
import 'package:playflutter/model/entity/account.dart';
import 'package:playflutter/model/http/constants/api_constants.dart';
import 'package:playflutter/theme/theme_constants.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/cache/preferences.dart';
import 'package:playflutter/view/account/model/account_model.dart';
import 'package:toast/toast.dart';

import '../../../widget/dialog/loading_dialog.dart';

/// @author jv.lee
/// @date 2022/8/3
/// @description 账户服务，应用存活期间常驻，全模块可调用账户服务
class AccountService extends BaseModuleService {
  final _model = AccountModel();
  final viewStates = AccountViewState();

  AccountService(super.context);

  @override
  void init() {}

  void requestAccountData(Function callback) async {
    _model.getAccountInfoAsync().then((value) {
      updateAccountStatus(value, true);
    }).catchError((error) async {
      // 登陆token失效
      if (error is HttpException &&
          error.message == ApiConstants.REQUEST_TOKEN_ERROR_MESSAGE) {
        updateAccountStatus(null, false);
        return;
      }
      // 获取本地数据
      var localAccount = await Preferences.localData(
          ThemeConstants.LOCAL_ACCOUNT_DATA,
          (json) => AccountData.fromJson(json));
      updateAccountStatus(localAccount, localAccount != null);
    }).whenComplete(() => callback());
  }

  void requestLogout(BuildContext context) {
    // 显示loading弹窗
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingDialog());

    _model.getLogoutAsync().then((value) {
      updateAccountStatus(null, false);
      Toast.show(ThemeStrings.accountLogoutSuccess);
    }).catchError((onError) {
      onFailedToast(onError);
    }).whenComplete(() => Navigator.pop(context));
  }

  void updateAccountStatus(AccountData? accountData, bool isLogin) {
    Preferences.localSave(ThemeConstants.LOCAL_ACCOUNT_DATA, accountData);
    Preferences.save(ThemeConstants.LOCAL_IS_LOGIN, isLogin);
    viewStates.accountData = accountData;
    viewStates.isLogin = isLogin;
    notifyListeners();
  }
}

class AccountViewState {
  AccountData? accountData;
  bool isLogin = false;
}
