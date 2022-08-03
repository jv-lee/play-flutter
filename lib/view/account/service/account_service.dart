import 'dart:io';

import 'package:playflutter/base/model_service.dart';
import 'package:playflutter/entity/account.dart';
import 'package:playflutter/theme/theme_constants.dart';
import 'package:playflutter/tools/local_tools.dart';
import 'package:playflutter/view/account/model/account_model.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/8/3
/// @description
class AccountService extends ModuleService {
  final _model = AccountModel();
  final viewStates = _AccountViewState();

  AccountService(super.context);

  @override
  void init() {}

  void requestAccountData() async {
    LocalTools.localRequest<AccountData>(
        ThemeConstants.ACCOUNT_DATA_LOCAL_KEY,
        (json) => AccountData.fromJson(json),
        _model.getAccountInfoAsync(), (value) {
      updateAccountStatus(value, true);
    }, (error) {
      // 登陆token失效
      if (error is HttpException &&
          error.message == ThemeConstants.REQUEST_TOKEN_ERROR_MESSAGE) {
        updateAccountStatus(null, false);
      }
    });
  }

  void requestLogout() {
    _model.getLogoutAsync().then((value) {
      updateAccountStatus(null, false);
      Toast.show("登出成功", context);
    }).catchError((onError) {
      Toast.show((onError as HttpException).message, context);
    });
  }

  void updateAccountStatus(AccountData? accountData, bool isLogin) {
    LocalTools.localSave(ThemeConstants.ACCOUNT_DATA_LOCAL_KEY, accountData);
    viewStates.accountData = accountData;
    viewStates.isLogin = isLogin;
    notifyListeners();
  }
}

class _AccountViewState {
  AccountData? accountData;
  bool isLogin = false;
}
