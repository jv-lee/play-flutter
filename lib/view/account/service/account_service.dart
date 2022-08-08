import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/base/base_model_service.dart';
import 'package:playflutter/model/entity/account.dart';
import 'package:playflutter/model/http/constants/api_constants.dart';
import 'package:playflutter/theme/theme_constants.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/local_tools.dart';
import 'package:playflutter/view/account/model/account_model.dart';
import 'package:toast/toast.dart';

import '../../../widget/dialog/loading_dialog.dart';

/// @author jv.lee
/// @date 2022/8/3
/// @description
class AccountService extends ModuleService {
  final _model = AccountModel();
  final viewStates = AccountViewState();

  AccountService(super.context);

  @override
  void init() {}

  void requestAccountData() async {
    LocalTools.localRequest<AccountData>(
        localKey: ThemeConstants.ACCOUNT_DATA_LOCAL_KEY,
        createJson: (json) => AccountData.fromJson(json),
        requestFuture: _model.getAccountInfoAsync(),
        callback: (value) => updateAccountStatus(value, true),
        onError: (error) {
          // 登陆token失效
          if (error is HttpException &&
              error.message == ApiConstants.REQUEST_TOKEN_ERROR_MESSAGE) {
            updateAccountStatus(null, false);
          }
        });
  }

  void requestLogout(BuildContext context) {
    // 显示loading弹窗
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingDialog());

    _model.getLogoutAsync().then((value) {
      updateAccountStatus(null, false);
      Toast.show(ThemeStrings.account_logout_success);
    }).catchError((onError) {
      Toast.show((onError as HttpException).message);
    }).whenComplete(() => Navigator.pop(context));
  }

  void updateAccountStatus(AccountData? accountData, bool isLogin) {
    LocalTools.localSave(ThemeConstants.ACCOUNT_DATA_LOCAL_KEY, accountData);
    viewStates.accountData = accountData;
    viewStates.isLogin = isLogin;
    notifyListeners();
  }
}

class AccountViewState {
  AccountData? accountData;
  bool isLogin = false;
}
