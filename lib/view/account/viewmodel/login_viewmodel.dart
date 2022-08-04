import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/view/account/model/account_model.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:playflutter/widget/dialog/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 登陆页面 viewModel
class LoginViewModel extends ViewModel {
  LoginViewModel(super.context);

  final accountModel = AccountModel();
  final viewStates = _LoginViewState();

  @override
  void init() {}

  @override
  void onCleared() {}

  void changeUserName(username) {
    viewStates.username = username;
    _changeLoginEnable();
  }

  void changePassword(password) {
    viewStates.password = password;
    _changeLoginEnable();
  }

  void _changeLoginEnable() {
    viewStates.stateColor =
        (viewStates.username.isNotEmpty && viewStates.password.isNotEmpty)
            ? Theme.of(context).focusColor
            : Colors.grey;
    notifyListeners();
  }

  void requestLogin() {
    // 显示loading弹窗
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingDialog());

    // 隐藏输入框 延时发起逻辑
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (viewStates.username.isEmpty || viewStates.password.isEmpty) {
        Navigator.pop(context);
        Toast.show("username || password is empty.");
        return;
      }

      accountModel
          .postLoginAsync(viewStates.username, viewStates.password)
          .then((userData) => accountModel.getAccountInfoAsync())
          .then((accountData) {
        context.read<AccountService>().updateAccountStatus(accountData, true);
        Navigator.pop(context);
      }).catchError((onError) {
        Toast.show((onError as HttpException).message);
      }).whenComplete(() => Navigator.pop(context));
    });
  }

  void navigationRegister() {
    Navigator.pushNamed(context, RouteNames.register).then((value) {
      // 获取注册页面结果回调直接关闭login页面
      if (value != null && value as bool) {
        Navigator.pop(context);
      }
    });
  }
}

class _LoginViewState {
  String username = "";
  String password = "";
  Color stateColor = Colors.grey;
}
