import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/extensions/function_extensions.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:playflutter/view/me/model/entity/me_item.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description
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
      Navigator.pushNamed(context, RouteNames.login);
    }
  }

  void itemClick(route) {
    // 无需校验登陆状态
    if (route == RouteNames.settings) {
      Navigator.pushNamed(context, route);
      return;
    }

    // 需要校验登陆状态
    if (viewStates.isLogin) {
      Navigator.pushNamed(context, route);
    } else {
      Toast.show(ThemeStrings.loginAlert);
      Navigator.pushNamed(context, RouteNames.login);
    }
  }

  void _changeViewState() {
    viewStates.isLogin = accountService.viewStates.isLogin;
    if (accountService.viewStates.isLogin) {
      accountService.viewStates.accountData?.data.run((self) {
        viewStates.headerWidget = Image.asset(ThemeImages.launcherRoundPng);
        viewStates.userName = self.userInfo.nickname;
        viewStates.userDesc =
            "等级：${self.coinInfo.level} 排名：${self.coinInfo.rank}";
      });
    } else {
      viewStates = _MeViewState();
    }
    notifyListeners();
  }
}

class _MeViewState {
  Widget headerWidget = Padding(
      padding: const EdgeInsets.all(6),
      child: SvgPicture.asset(ThemeImages.meAccountSvg));
  String userName = ThemeStrings.meAccountDefaultText;
  String userDesc = "";
  bool isLogin = false;
  List<MeItem> meItems = MeItem.getMeItems();
}
