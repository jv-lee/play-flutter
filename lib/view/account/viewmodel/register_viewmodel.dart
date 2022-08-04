import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/view/account/model/account_model.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:playflutter/widget/dialog/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 注册页面 viewModel
class RegisterViewModel extends ViewModel {
  final accountModel = AccountModel();
  final viewStates = _RegisterViewState();

  RegisterViewModel(super.context);

  @override
  void init() {}

  @override
  void onCleared() {}

  void changeUserName(username) {
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

  void _changeRegisterEnable() {
    viewStates.isRegisterEnable = viewStates.username.isNotEmpty &&
        viewStates.password.isNotEmpty &&
        viewStates.rePassword.isNotEmpty;
    notifyListeners();
  }

  void requestRegister() {
    // 显示loading弹窗
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingDialog());

    // 隐藏输入框 延时发起逻辑
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (viewStates.username.isEmpty ||
          viewStates.password.isEmpty ||
          viewStates.rePassword.isEmpty) {
        Navigator.pop(context);
        Toast.show("username || password || repassword is empty.");
        return;
      }

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
}

class _RegisterViewState {
  String username = "";
  String password = "";
  String rePassword = "";
  bool isRegisterEnable = false;
}
