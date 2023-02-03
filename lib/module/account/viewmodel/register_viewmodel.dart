import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/widget/dialog/loading_dialog.dart';
import 'package:playflutter/module/account/model/account_model.dart';
import 'package:playflutter/module/account/service/account_service.dart';
import 'package:playflutter/module/account/theme/theme_account.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 注册页面 viewModel
class RegisterViewModel extends BaseViewModel {
  final accountModel = AccountModel();
  final viewStates = _RegisterViewState();

  RegisterViewModel(super.context);

  @override
  void init() {}

  @override
  void onCleared() {}

  void changeUsername(username) {
    viewStates.username = username;
    _changeRegisterEnable();
  }

  void changePassword(password) {
    viewStates.password = password;
    _changeRegisterEnable();
  }

  void changeRePassword(password) {
    viewStates.rePassword = password;
    _changeRegisterEnable();
  }

  void requestRegister() {
    // 校验是否输入帐号及密码
    if (_checkInputCompliance() == false) {
      return;
    }

    // 显示loading弹窗
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingDialog());

    // 隐藏输入框 延时发起逻辑
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(const Duration(milliseconds: 300), () {
      accountModel
          .postRegisterAsync(
              viewStates.username, viewStates.password, viewStates.rePassword)
          .then((userData) => accountModel.getAccountInfoAsync())
          .then((accountData) {
        context.read<AccountService>().updateAccountStatus(accountData, true);
        Navigator.pop(context);
      }).catchError((onError) {
        Toast.show((onError as HttpException).message);
        // 携带参数回调登陆页面
      }).whenComplete(() => Navigator.pop(context, true));
    });
  }

  void _changeRegisterEnable() {
    viewStates.stateColor = (viewStates.username.isNotEmpty &&
        viewStates.password.isNotEmpty &&
        viewStates.rePassword.isNotEmpty)
        ? Theme.of(context).focusColor
        : Colors.grey;
    notifyListeners();
  }

  bool _checkInputCompliance() {
    if (viewStates.username.isEmpty ||
        viewStates.password.isEmpty ||
        viewStates.rePassword.isEmpty) {
      Toast.show(ThemeAccount.strings.registerInputEmpty);
      return false;
    }
    return true;
  }

}

class _RegisterViewState {
  String username = "";
  String password = "";
  String rePassword = "";
  Color stateColor = Colors.grey;
}
