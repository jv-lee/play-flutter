import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/module/account/service/account_service.dart';
import 'package:playflutter/module/account/theme/theme_account.dart';
import 'package:playflutter/module/me/model/entity/me_item.dart';
import 'package:playflutter/module/me/theme/theme_me.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 我的页面 viewModel
class MeViewModel extends BaseViewModel {
  var viewStates = _MeViewState();
  late AccountService accountService;

  MeViewModel(super.context);

  @override
  void init() {
    accountService = context.read<AccountService>();
    accountService.addListener(_changeViewState);
    _changeViewState();
  }

  @override
  void onCleared() {
    accountService.removeListener(_changeViewState);
  }

  void headerClick() {
    if (!viewStates.isLogin) {
      Navigator.pushNamed(context, ThemeAccount.routes.login);
    }
  }

  void itemClick(route) {
    // 无需校验登陆状态
    if (route == ThemeMe.routes.settings) {
      Navigator.pushNamed(context, route);
      return;
    }

    // 需要校验登陆状态
    if (viewStates.isLogin) {
      Navigator.pushNamed(context, route);
    } else {
      Toast.show(ThemeCommon.strings.loginAlert);
      Navigator.pushNamed(context, ThemeAccount.routes.login);
    }
  }

  void _changeViewState() {
    accountService.viewStates.run((self) {
      if (self.isLogin) {
        viewStates
          ..userName = self.nickname
          ..userDesc = "等级：${self.level} 排名：${self.rank}"
          ..headerWidget = Image.asset(ThemeCommon.images.launcherRoundPng);
      } else {
        viewStates = _MeViewState();
      }
      viewStates.isLogin = self.isLogin;
      notifyListeners();
    });
  }
}

class _MeViewState {
  Widget headerWidget = Padding(
      padding: const EdgeInsets.all(6),
      child: SvgPicture.asset(ThemeMe.images.accountSvg));
  String userName = ThemeMe.strings.meAccountDefaultText;
  String userDesc = "";
  bool isLogin = false;
  List<MeItem> meItems = MeItem.getMeItems();
}
